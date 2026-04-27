-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('支付流水', '2000', '1', 'OrdPayment', 'order/OrdPayment/index', 1, 0, 'C', '0', '0', 'order:OrdPayment:list', '#', 'admin', sysdate(), '', null, '支付流水菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('支付流水查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'order:OrdPayment:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('支付流水新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'order:OrdPayment:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('支付流水修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'order:OrdPayment:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('支付流水删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'order:OrdPayment:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('支付流水导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'order:OrdPayment:export',       '#', 'admin', sysdate(), '', null, '');