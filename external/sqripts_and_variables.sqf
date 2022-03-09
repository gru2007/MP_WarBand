// AUTOCOMBAT:

{_x disableAI "AUTOCOMBAT"} forEach (units group_2);

// Переменные:

PC_RECON_MOVING_DIST = 200;
PC_ENEMY_SIDE = "EAST";

// Скрипты и функции:﻿

PC_fn_forget_all_targets = 
	{
		params ["_leader"];
		
		_targets = _leader targets [true, 500, [], 0];
			{ 
				group _leader forgetTarget _x; 
			} forEach _targets;
	};
	
PC_fn_recon_path_do_not_intersect_enemy_zones = 
	{
		params ["_start_pos", "_end_pos", "_radius", "_enemies"];
		
		_do_not_intersect = true;	
		
		if (count _enemies < 1) exitWith 
			{
				_do_not_intersect;				
			};
			
			{
				_enemy = _x;
				
				_nearest_position = [_start_pos, _end_pos, position _enemy, true] call BIS_fnc_nearestPoint;
				
				if (_nearest_position distance2D _enemy < _radius) then 
					{						
						if ((_start_pos distance2d _nearest_position) + (_end_pos distance2d _nearest_position) > (_start_pos distance2d _end_pos)+1) then 
							{
								switch (true) do
									{
										case (_start_pos distance2d _nearest_position < _radius): 	
											{ _do_not_intersect = false; };
										case (_end_pos distance2d _nearest_position < _radius): 	
											{ _do_not_intersect = false; };
									};
							} else 
								{
									_do_not_intersect = false; 
								};
					};				
			} forEach _enemies;
			
		_do_not_intersect;
	};
	
PC_direct_fn_allies_recon = 
	{
		params ["_group","_action_position"];
		
		private _leader = leader _group;
		private _name = format ["%1_PC_WP_NAME_recon_%2", _group, (count waypoints _group)];
				
		private _wp1 = group _leader addWaypoint [_action_position, 0, (count waypoints _leader) + 1];		
		_wp1 setWaypointName _name;
		_wp1 setWaypointType "SCRIPTED";
		
		_group setFormation "FILE";
		waitUntil {formation _group in ["FILE"]};
				
		_script = [_leader, _action_position] spawn PC_direct_fn_allies_are_reconing;
		
		private _wp1 = group _leader addWaypoint [_action_position, 0, (count waypoints _leader) + 1];		
		_wp1 setWaypointName _name;
		_wp1 setWaypointType "MOVE";
		//_wp1 setWaypointBehaviour "STEALTH"; 
		//_wp1 setWaypointForceBehaviour true;
		_wp1 setWaypointCombatMode "GREEN";
		_wp1 setWaypointFormation "DIAMOND";
		//_wp1 setWaypointSpeed "NORMAL";
		_wp1 setWaypointStatements ["true", "group this setVariable ['PC_AI_isReconing', false, true]; "];		
	};
	
PC_direct_fn_allies_are_reconing = 
	{
		params ["_recon","_action_position"];		
		
		_group = leader _recon;
		_merged_enemies_on_the_path = [];
		
		/// Подготовка отделения:
		
			{
				//_x setUnitPos "MIDDLE";
				//_x setBehaviour "STEALTH";
				_x setBehaviour "AWARE"; 
				_x setCombatMode "GREEN";
				_x setUnitTrait ["audibleCoef", (_x getUnitTrait "audibleCoef")/2];
				_x setUnitTrait ["camouflageCoef", (_x getUnitTrait "camouflageCoef")/2];
				_x disableAI "AUTOCOMBAT";
			} forEach units group _recon;

		group _recon setVariable ["PC_AI_isReconing", true, true];
		group _recon setVariable ["PC_AI_recon_at_his_last_temperary_point", false, true];
		group _recon setVariable ["PC_AI_recon_path", [], true]; 
		
		[_recon] call PC_fn_forget_all_targets;
		
		_goal_waypoint = []; 
						
			{
				if (
					(waypointPosition _x distance2d _action_position < 5)
					&&
					((waypointName _x) find "_recon_" != -1)
					) exitWith 
						{
							_goal_waypoint = _x;
						};
			} forEach waypoints (group _recon);
		
		/// Цикл разведки:
				
		while {group _recon getVariable "PC_AI_isReconing"} do /// Основной цикл разведки
			{				
				/// Фиксация известных группе врагов:
				
				_all_known_targets_before = _recon targets [true];
				
				_all_enemy_leaders = _all_known_targets_before apply { (leader group _x) };
				_all_enemy_leaders = _all_enemy_leaders arrayIntersect _all_enemy_leaders;
			
				/// Получение временных мар точек из переменной PC_AI_recon_path:
				
				if (count (group _recon getVariable ["PC_AI_recon_path", []]) > 0 ) then 
					{
						/// Есть обходной путь, ставим временные мар точки:					
							
						_goal_waypoint_index = _goal_waypoint select 1;

						_first_temporary_waypoint_index = 0;
						
						for "_i" from 0 to (count (group _recon getVariable ["PC_AI_recon_path", []]))-1 do 
							{
								_name = format ["%1_PC_WP_NAME_temporary_%2", _group, _i];
								
								_wp1 = group _recon addWaypoint [(group _recon getVariable ["PC_AI_recon_path", []]) select _i, 0, _goal_waypoint_index + 1 + _i];		
								_wp1 setWaypointName _name;
								_wp1 setWaypointType "MOVE";
								
								/// Получаем индекс первой временной точки:							
								
								if (_i == 0) then 
									{
										_first_temporary_waypoint_index = _goal_waypoint_index + 1; 
										group _recon setCurrentWaypoint [group _recon, _first_temporary_waypoint_index];										
									};
								
								/// Если это последняя временная точка:
								
								if (_i == (count (group _recon getVariable ["PC_AI_recon_path", []]))-1) then 
									{									
										_wp1 setWaypointStatements ["true", "(group this) setVariable ['PC_AI_recon_at_his_last_temperary_point', true, true]"];
										
										/// Если эта последняя временная точка должна стать завершением разведки:
										
										if !([_action_position, _action_position, PC_RECON_MOVING_DIST, _merged_enemies_on_the_path] call PC_fn_recon_path_do_not_intersect_enemy_zones) then 
											{												
												_wp1 setWaypointStatements ["true", "[(group this), (currentWaypoint (group this))+1] setWaypointPosition [position this, 0];"];
											};											
											
										/// После создания всех временных маршрутных точек переводим группу на первую временную точку:
										
										group _recon setCurrentWaypoint [group _recon, _first_temporary_waypoint_index];
									};
								/*	
								_marker = createMarker ["enemy_marker_" + (str time) + "_" + (str _i), (group _recon getVariable ["PC_AI_recon_path", []]) select _i];
								_marker setMarkerType "Contact_pencilCircle2";
								_marker setMarkerColor "ColorBlue";
								_marker setMarkerText format ["%1", _i + 1];*/
							};						
					};				
				
				/// Цикл ожидания для повтора вычисления пути или выхода из разведки:								
				
				waitUntil 
					{
						sleep 1;
						
						_recon = leader _group;
						
						/// Проверка, каких врагов группа видит:

						_all_targets = (nearestObjects [_recon, ["Land","Air"], 300]) select 
							{
								(alive _x) 
								&& 
								(side group _x isEqualTo PC_ENEMY_SIDE) 
								&& 
								([position _recon, getDir _recon, 180, position _x] call BIS_fnc_inAngleSector) 
								&& 
								(([objNull, "IFIRE"] checkVisibility [eyePos _recon, eyepos _x] > 0.0001))
							};
										
						if (count _all_targets > 0) then
							{
								{
									_target = _x;
									_recon reveal [_target, 2];
									leader group _recon reveal [_target, 2];								
								} forEach _all_targets;								
							};
						
						_all_known_targets = _recon targets [true];
						_all_enemy_leaders = [];
						
						if (count _all_known_targets > 0) then 
							{
								_all_enemy_leaders = _all_known_targets apply { (leader group _x) };								
								_all_enemy_leaders = _all_enemy_leaders arrayIntersect _all_enemy_leaders;
							};						
						
						/// Условия выхода из ожидания:
						 
						!(group _recon getVariable "PC_AI_isReconing") /// Группа отозвана или закончила разведку
						||
						(if (count _all_known_targets_before > 0) then {({if !(_x in _all_known_targets_before) exitWith {true}; false} forEach (_recon targets [true]))} else {if (count (_recon targets [true]) > 0) then {true} else {false}})   /// Появился новый враг
						||
						(group _recon getVariable ["PC_AI_recon_at_his_last_temperary_point", false]); /// Разведчики дошли до последней временной точки
					};
					
				/// Удаляем все маркеры старых маршрутов:
				
					{
						if ((_x find "enemy_marker_" != -1) || (_x find "goal_marker_" != -1)) then 
							{
								deleteMarker _x;
							};
					} forEach allMapMarkers;
					
				/// Если это обход противника, в зоне которого конечное назначение:
				
				if ((group _recon getVariable ["PC_AI_recon_at_his_last_temperary_point", false]) && (_recon distance2d (waypointPosition _goal_waypoint) < 10)) then 
					{
						group _recon setVariable ["PC_AI_isReconing", false, true]; 
					};
				
				/// Удаление временных маршрутных точек:
				
				_group_waypoints = waypoints group _recon;
				reverse _group_waypoints;
					{
						if (waypointName _x find "_temporary" != -1) then 
							{
								deleteWaypoint _x;
							};
					} forEach _group_waypoints;				
				
				group _recon setVariable ["PC_AI_recon_at_his_last_temperary_point", false, true];
				group _recon setVariable ["PC_AI_recon_path", [], true];			
				
				/// Если разведку отменили или разведка дошла до своей конечной цели:
				
				if !(group _recon getVariable "PC_AI_isReconing") exitWith 
					{
						/// Выход из разведки: 						
					};				

				/// Начинается проверка:				
				/// Определение врагов на глаз плюс всех известных до этого целей:				
				
				_all_targets = (nearestObjects [_recon, ["Land","Air"], 300]) select 
					{
						(alive _x) 
						&& 
						(side group _x isEqualTo PC_ENEMY_SIDE) 
						&& 
						([position _recon, getDir _recon, 180, position _x] call BIS_fnc_inAngleSector) 
						&& 
						(([objNull, "IFIRE"] checkVisibility [eyePos _recon, eyepos _x] > 0.0001))
					};
								
				if (count _all_targets > 0) then
					{
						{
							_target = _x;
							_recon reveal [_target, 2];
							leader group _recon reveal [_target, 2];								
						} forEach _all_targets;								
					};
				
				_all_known_targets = _recon targets [true];
				
				/// Если известны враги, находим путь для их обхода:
				
				if (count _all_known_targets > 0) then 
					{
						_all_enemy_leaders = _all_known_targets apply { (leader group _x) };
						
						_all_enemy_leaders = _all_enemy_leaders arrayIntersect _all_enemy_leaders;
						_all_enemy_leaders_and_distance = _all_enemy_leaders apply { [_x distance (leader group _recon), _x] };
						_all_enemy_leaders_and_distance sort true;
						_closest_enemy = _all_enemy_leaders_and_distance select 0 select 1;
								
						_recon_dir_to_end = _recon getDir _action_position;
						_recon_dir_to_closest_enemy = _recon getDir _closest_enemy;
						
						/// Проверяем, есть ли кто-то из этих врагов на пути группы:																		
								
						if ([position _recon, _action_position, PC_RECON_MOVING_DIST, _all_enemy_leaders] call PC_fn_recon_path_do_not_intersect_enemy_zones) exitWith 
							{
								/// Нет пересечения с опасными зонами. Повторение цикла:								
							};	
						
						/// Создаем массив с точками вокруг всех известных врагов.
						
						_all_positions_around_enemies_and_distance_to_recon = [];
						
							{
								_enemy_pos = (_x select 1);
								
								for "_i" from 0 to 7 do 
									{
										_pos = _enemy_pos getPos [PC_RECON_MOVING_DIST + (PC_RECON_MOVING_DIST/10), _recon_dir_to_end + (45*_i)];
										
										_all_positions_around_enemies_and_distance_to_recon = _all_positions_around_enemies_and_distance_to_recon + [[_recon distance2d _pos, _pos]];
									};
								
							} forEach _all_enemy_leaders_and_distance;
						
						/// Убираем из массива те точки, которые попадают в радиус других врагов:
						
						_merged_positions = [];
						
							{								
								_pos = (_x select 1);
								
								if ({if (_pos distance2d _x < PC_RECON_MOVING_DIST) exitWith {true}; false} forEach _all_enemy_leaders) then 
									{
										_merged_positions = _merged_positions + [_x];
									};
									
							} forEach _all_positions_around_enemies_and_distance_to_recon;
						
						_all_positions_around_enemies_and_distance_to_recon = _all_positions_around_enemies_and_distance_to_recon - _merged_positions;
												
						/// Вычисляем тех врагов, через которых проходит путь:
						
						_enemy_leaders_on_the_path = [];
						
							{
								if !([position _recon, _action_position, PC_RECON_MOVING_DIST, [_x]] call PC_fn_recon_path_do_not_intersect_enemy_zones) then 
									{
										_enemy_leaders_on_the_path = _enemy_leaders_on_the_path + [_x];
									};
							} forEach _all_enemy_leaders;
							
						/// Из них ближайший:
						
						_enemy_leaders_on_the_path_and_distance = _enemy_leaders_on_the_path apply {[_x distance2d _recon, _x]};
						_enemy_leaders_on_the_path_and_distance sort true;
						_closest_enemy_on_the_path = _enemy_leaders_on_the_path_and_distance select 0 select 1;
						
						/// Проверяем, кто из врагов приклеен зоной к первому врагу на пути:
						
						_merged_enemies_on_the_path = [_closest_enemy_on_the_path]; 
						
							{
								_leader = (_x select 1);
								
								if ({if (_leader distance2d _x < (PC_RECON_MOVING_DIST*2)) exitWith {true}; false} forEach _merged_enemies_on_the_path) then 
									{
										_merged_enemies_on_the_path = _merged_enemies_on_the_path + [_leader];
									};
									
								sleep 0.1;
								
							} forEach _all_enemy_leaders_and_distance;
						
						_merged_enemies_on_the_path = _merged_enemies_on_the_path arrayIntersect _merged_enemies_on_the_path;
						
						/// Удаляем те точки, которые не от этих врагов:
						
						_positions_not_merged = [];
						
							{
								_pos = (_x select 1);
								
								if ({if ((_pos distance2d _x) < (5 + PC_RECON_MOVING_DIST + (PC_RECON_MOVING_DIST/10))) exitWith {false}; true} forEach _merged_enemies_on_the_path) then 
									{
										_positions_not_merged = _positions_not_merged + [_x];
									};
							} forEach _all_positions_around_enemies_and_distance_to_recon;
						
						_all_positions_around_enemies_and_distance_to_recon = _all_positions_around_enemies_and_distance_to_recon - _positions_not_merged;
						
						///Тест: создаем маркеры:
						
							{
								_marker = createMarker ["enemy_marker_" + (str time) + (str _forEachIndex), (_x select 1)];
								_marker setMarkerType "mil_dot_noShadow";
								_marker setMarkerColor "ColorBlack";
								//_marker setMarkerAlpha 1;								
							} forEach _all_positions_around_enemies_and_distance_to_recon;
						
						sleep 0.001;
												
						
						/// Пересечение с опасными зонами. Определяем те точки, до которых группа дойдет не пересекая опасные сектора:
												
						_closest_point = [];
						_farest_point = [];
						
						if ({if (_recon distance2d _x < PC_RECON_MOVING_DIST + (PC_RECON_MOVING_DIST/10)) exitWith {true}; false} forEach _all_enemy_leaders) then 
							{
								/// Группа оказалась в опасном секторе. Отходит к ближайшей позиции за радиус опасного сектора:
								
								_all_positions_around_enemies_and_distance_to_recon sort true;
								
								_closest_point = _all_positions_around_enemies_and_distance_to_recon select 0 select 1;
								/*
								_marker = createMarker ["enemy_marker_" + (str time), _closest_point];
								_marker setMarkerType "mil_dot_noShadow";
								_marker setMarkerColor "ColorRed";*/
								
							} else 
								{
									/// Группа вне опасного сектора. Ищет наиболее дальнюю позицию от разведчика с учетом не пересечения опасных зон:
									
									_all_positions_around_enemies_and_distance_to_recon sort false;
									
										{
											_pos = (_x select 1);
														
											if ([position _recon, _pos, PC_RECON_MOVING_DIST, _all_enemy_leaders] call PC_fn_recon_path_do_not_intersect_enemy_zones) exitWith 
												{
													/// эта точка дальше всего от группы и не пересекает опасную зону:
													
													_farest_point = _pos;
													/*
													_marker = createMarker ["enemy_marker_" + (str time), _farest_point];
													_marker setMarkerType "mil_dot_noShadow";
													_marker setMarkerColor "ColorBlue";*/
												};								
								
										} forEach _all_positions_around_enemies_and_distance_to_recon;									
								};
						
						/// Проверка, не пройдет ли группа от ближайшей или наиболее дальней точки сразу к цели:
						
						switch (true) do
							{
								case (count _closest_point > 0): 
									{
										if ([_closest_point, _action_position, PC_RECON_MOVING_DIST, _all_enemy_leaders] call PC_fn_recon_path_do_not_intersect_enemy_zones) exitWith	
											{
												/// Нет пересечения с опасными зонами:
											
												group _recon setVariable ["PC_AI_recon_path", [_closest_point], true];												
											};	
									};
								case (count _farest_point > 0): 
									{										
										if ([_farest_point, _action_position, PC_RECON_MOVING_DIST, _all_enemy_leaders] call PC_fn_recon_path_do_not_intersect_enemy_zones) exitWith	
											{
												/// Нет пересечения с опасными зонами:
											
												group _recon setVariable ["PC_AI_recon_path", [_farest_point], true];
											};	
									};
							};						
							
						if (count (group _recon getVariable ["PC_AI_recon_path", []]) > 0) exitWith 
							{
								/// Есть путь. Возвращение назад к началу цикла:								
							};						
						
						/// Группа не может пройти через ближайшую или наиболее дальнюю точку сразу до цели. Определение двух ближайших точек по обе стороны от группы:
						
						_all_positions_around_enemies_and_distance_to_recon sort true;
						
						_closest_position = _all_positions_around_enemies_and_distance_to_recon select 0 select 1;						
						
						//---------- TEST
						/*
						_marker = createMarker ["enemy_marker_" + (str time), _closest_position];
						_marker setMarkerType "mil_dot_noShadow";
						_marker setMarkerColor "ColorGreen";
						*/
						//----------
						
						_fake_object = createVehicle ["Land_InvisibleBarrier_F", position _recon, [], 1, "CAN_COLLIDE"];
						_fake_object setDir (_recon getDir _action_position);						
						
						_left_side_positions = [];
						_right_side_positions = [];
						
						_all_positions_around_enemies_and_distance_to_recon = _all_positions_around_enemies_and_distance_to_recon - [_closest_position];
						
						/// Здесь, если зона врага пересекается всего в одной точке, выход с путем из одной точки:
						
						if (count _all_positions_around_enemies_and_distance_to_recon < 1) exitWith 
							{
								group _recon setVariable ["PC_AI_recon_path", [_closest_position], true];
							};
						
						/// Если путь состоит из больше, чем одной точки:
						
							{
								_pos = (_x select 1);
								
								if (_fake_object getRelDir _pos < 180) then 
									{
										_right_side_positions = _right_side_positions + [_pos];
									} else 
										{
											_left_side_positions = _left_side_positions + [_pos];
										};
							} forEach _all_positions_around_enemies_and_distance_to_recon;
												
						sleep 0.001;						
						
						deleteVehicle _fake_object;
					
						/// Ищем позицию на второй стороне зоны:
						
						_position_on_other_side = [];
						
						_all_positions_around_enemies_and_distance_to_recon_and_to_line = _all_positions_around_enemies_and_distance_to_recon apply {[(([position _recon, _action_position, (_x select 1), true] call BIS_fnc_nearestPoint) distance2d (_x select 1))] + _x};
						_all_positions_around_enemies_and_distance_to_recon_and_to_line sort true;
						
						_all_positions_around_enemies_and_distance_to_recon_and_to_line resize 4;
						
						_all_positions_around_enemies_and_distance_to_recon_and_to_line = _all_positions_around_enemies_and_distance_to_recon_and_to_line apply {[(_x select 1),(_x select 2)]};
						_all_positions_around_enemies_and_distance_to_recon_and_to_line sort false;
						
						_position_on_other_side = _all_positions_around_enemies_and_distance_to_recon_and_to_line select 0 select 1;
						
						//---------- TEST
						/*
						_marker = createMarker ["enemy_marker_" + (str time), _position_on_other_side];
						_marker setMarkerType "mil_dot_noShadow";
						_marker setMarkerColor "ColorYellow";
						*/
						//----------
							
						/// Вычисление пути с двух сторон:

						_left_side_positions = _left_side_positions + [_position_on_other_side];
						_right_side_positions = _right_side_positions + [_position_on_other_side];
						
						_left_side_positions = _left_side_positions arrayIntersect _left_side_positions;
						_right_side_positions = _right_side_positions arrayIntersect _right_side_positions;
						
						_left_side_positions_and_distances = _left_side_positions apply {[(_x distance2D _closest_position), _x]};
						_left_side_positions_and_distances sort true;
						_first_left_side_position = _left_side_positions_and_distances select 0 select 1;
						
						_right_side_positions_and_distances = _right_side_positions apply {[(_x distance2D _closest_position), _x]};
						_right_side_positions_and_distances sort true;
						_first_right_side_position = _right_side_positions_and_distances select 0 select 1;
						
						_left_path = [_closest_position, _first_left_side_position];
						_right_path = [_closest_position, _first_right_side_position];
						
						_left_path_dist = 0;
						_right_path_dist = 0;
						
							{
								if (_forEachIndex == ((count _right_side_positions)-1)) exitWith {};
								
								private _last_pos = _right_path select ((count _right_path)-1);
								
								private _pos_array = _right_side_positions select {!(_x in _right_path)};
								
								_pos_array = _pos_array apply {[(_x distance2D _last_pos), _x]};
								
								_pos_array sort true;
								
								private _new_pos = _pos_array select 0 select 1;
								
								_right_path = _right_path + [_new_pos];
								
								_right_path_dist = _right_path_dist + (_last_pos distance2d _new_pos);
								
							} forEach _right_side_positions;
							
							{
								if (_forEachIndex == ((count _left_side_positions)-1)) exitWith {};
								
								private _last_pos = _left_path select ((count _left_path)-1);
								
								private _pos_array = _left_side_positions select {!(_x in _left_path)};
								
								_pos_array = _pos_array apply {[(_x distance2D _last_pos), _x]};
								
								_pos_array sort true;
								
								private _new_pos = _pos_array select 0 select 1;
								
								_left_path = _left_path + [_new_pos];
								
								_left_path_dist = _left_path_dist + (_last_pos distance2d _new_pos);
								
							} forEach _left_side_positions;		
						
						/// Определяем, с какой стороны обходить:
						
						_path = [];
						
						if (_left_path_dist > _right_path_dist) then 
							{
								_path = _right_path;
							} else 
								{
									_path = _left_path;
								};
								
						/// Если конечная точка не находится в зоне врага, отрезаем от пути те точки, которые можно сократить:
						
						_shorten_path = _path;
						
						/// Наиболее далекая точка:
						
							{
								_pos = _x;
								
								if ([_action_position, _pos, PC_RECON_MOVING_DIST, _all_enemy_leaders] call PC_fn_recon_path_do_not_intersect_enemy_zones) exitWith 
									{
										_index = _shorten_path find _pos;
										
										_shorten_path resize (_index + 1);
									};
							} forEach _path;
						
						reverse _shorten_path;
						
						/// Наиболее близкая точка:
						
							{
								_pos = _x;
								
								if ([position _recon, _pos, PC_RECON_MOVING_DIST, _all_enemy_leaders] call PC_fn_recon_path_do_not_intersect_enemy_zones) exitWith 
									{
										_index = _shorten_path find _pos;
										
										_shorten_path resize (_index + 1);
									};
							} forEach _shorten_path;
							
						reverse _shorten_path;
						
						/// Проверка, не находится ли конечное место разведки в зоне известных врагов, с которыми пересекается путь:
						
						if !([_action_position, _action_position, PC_RECON_MOVING_DIST, _merged_enemies_on_the_path] call PC_fn_recon_path_do_not_intersect_enemy_zones) then 
							{		
								_shorten_path_to_cut = _shorten_path;
								_shorten_path_to_cut_1 = _shorten_path;
								
								_shorten_path_to_cut_and_distances = _shorten_path_to_cut apply {[(_x distance2d _action_position), _x]};
								_shorten_path_to_cut_and_distances sort true;
								_position_with_shortes_distance = _shorten_path_to_cut_and_distances select 0 select 1;
								
									{
										if (_x isEqualTo _position_with_shortes_distance) exitWith 
											{
												_shorten_path resize (_forEachIndex + 1);
											};
									} forEach _shorten_path_to_cut_1;								
							};
						
						
						/// TEST			
							
							{								
								_marker = createMarker ["enemy_marker_" + (str time) + (str _forEachIndex), _x];
								_marker setMarkerType "Contact_pencilCircle2";
								_marker setMarkerColor "ColorWhite";
								_marker setMarkerText str (_forEachIndex +1);
								//_marker setMarkerAlpha 1;								
							} forEach _shorten_path;
						sleep 0.001;
						
						
						/// Есть путь. Возврашение к началу цикла:
						
						group _recon setVariable ["PC_AI_recon_path", _shorten_path, true];
						
					} else 
						{
							/// Враги не известны, продолжаем движение
						};			
			}; 
		
		/// Выход из маршрутной точки:
		
		_group setVariable ["PC_AI_recon_at_his_last_temperary_point", false, true];
		_group setVariable ["PC_AI_recon_path", [], true];
		
			{
				_x setUnitPos "AUTO";
				//_x setBehaviour "STEALTH";
				_x setBehaviour "AWARE";
				//_x setCombatMode "GREEN";
				_x setUnitTrait ["audibleCoef", (_x getUnitTrait "audibleCoef")*2];
				_x setUnitTrait ["camouflageCoef", (_x getUnitTrait "camouflageCoef")*2];
			} forEach units group _recon;
	};