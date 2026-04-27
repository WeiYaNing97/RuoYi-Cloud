-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('积分流水', '2019', '1', 'PtsLog', 'points/PtsLog/index', 1, 0, 'C', '0', '0', 'points:PtsLog:list', '#', 'admin', sysdate(), '', null, '积分流水菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('积分流水查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'points:PtsLog:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('积分流水新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'points:PtsLog:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('积分流水修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'points:PtsLog:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('积分流水删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'points:PtsLog:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('积分流水导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'points:PtsLog:export',       '#', 'admin', sysdate(), '', null, '');