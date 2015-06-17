
/* t_permission1 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (1,'manager:user:list',1,'用户列表','/manager/user/list',NULL,'2015-06-10 00:11:14');
/* t_permission2 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (2,'manager:authority:users:list',1,'用户权限','/manager/authority/users/list',NULL,'2015-06-10 21:32:50');
/* t_permission3 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (3,'manager:authority:roles:list',1,'角色列表','/manager/authority/roles/list',NULL,'2015-06-10 21:12:51');
/* t_permission4 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (4,'manager:authority:permissions:list',1,'权限列表','/manager/authority/permissions/list',NULL,'2015-06-10 00:14:53');
/* t_permission5 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (5,'customer:list',0,NULL,NULL,NULL,NULL);
/* t_permission6 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (6,'photographer:order:list',1,'摄影师订单列表','',NULL,'2015-06-10 00:16:47');
/* t_permission7 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (7,'manager:user:update',0,'用户修改','',NULL,'2015-06-10 22:31:18');
/* t_permission 8*/
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (8,'manager:user:delete',0,'用户删除','',NULL,'2015-06-10 22:32:06');
/* t_permission9 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (9,'manager:user:query',0,'用户查询','',NULL,'2015-06-10 22:32:49');
/* t_permission10 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (10,'photographer:user:info',1,'摄影师个人信息','',NULL,'2015-06-10 23:50:32');
/* t_permission11 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (11,'photographer:user:authenticate',1,'摄影师申请认证','',NULL,'2015-06-10 23:51:45');
/* t_permission12 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (12,'photographer:user:goods',1,'摄影师拍摄服务','',NULL,'2015-06-10 23:52:32');
/* t_permission13 */
INSERT INTO `t_permission` (`id`, `name`, `ismenu`, `al`, `dt`, `ct`, `ut`) VALUES (13,'photographer:user:works',1,'摄影师作品管理','',NULL,'2015-06-10 23:53:00');

/* t_role1 */
INSERT INTO `t_role` (`id`, `name`, `al`, `dt`, `ct`, `ut`) VALUES (1,'admin',NULL,NULL,NULL,NULL);
/* t_role2 */
INSERT INTO `t_role` (`id`, `name`, `al`, `dt`, `ct`, `ut`) VALUES (2,'photographer',NULL,NULL,NULL,NULL);

/* t_role_permission1 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (1,4);
/* t_role_permission2 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (1,3);
/* t_role_permission3 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (1,2);
/* t_role_permission4 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (1,8);
/* t_role_permission5 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (1,1);
/* t_role_permission6 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (1,9);
/* t_role_permission7 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (1,7);
/* t_role_permission8 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (2,6);
/* t_role_permission9 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (2,11);
/* t_role_permission10 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (2,12);
/* t_role_permission11 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (2,10);
/* t_role_permission12 */
INSERT INTO `t_role_permission` (`role_id`, `permission_id`) VALUES (2,13);
/* t_user_role1 */
INSERT INTO `t_user_role` (`u_id`, `role_id`) VALUES (6,1);
/* t_user_role2 */
INSERT INTO `t_user_role` (`u_id`, `role_id`) VALUES (8,2);
/* system_user1 */
INSERT INTO `user_general_info` (`id`, `user_type`, `user_name`, `email`, `password`, `family_name`, `last_name`, `mobile`, `telephone`, `location`, `birthday`, `head_thumb`, `begin_time`, `gender`, `salt`, `register_check_state`, `authentication_stat`, `ct`, `ut`) VALUES (4,2,'p1','p1@163.com','2cd219b84fcf931438219a558da238e0f8089fa0f3278f29f1464b7fe0188a98','p1','p1','13412341234',NULL,NULL,'2015-06-10 21:54:46',NULL,'2015-06-10 21:54:46',NULL,'05b4db3604f941ea97cc230aef08fe8f',1,0,'2015-06-10 21:54:46','2015-06-10 21:54:46');
/* system_user2 */
INSERT INTO `user_general_info` (`id`, `user_type`, `user_name`, `email`, `password`, `family_name`, `last_name`, `mobile`, `telephone`, `location`, `birthday`, `head_thumb`, `begin_time`, `gender`, `salt`, `register_check_state`, `authentication_stat`, `ct`, `ut`) VALUES (5,1,'c1','c1@163.com','ae8dd746a5154b205068ecf59939f7c481361b8144e21ec5ed086a1dedf01e25','c1','c1','13412341234',NULL,NULL,'2015-06-10 21:54:46',NULL,'2015-06-10 21:54:46',NULL,'4997e75a2b3148e184ad516ecda0358e',2,0,'2015-06-10 21:54:46','2015-06-10 22:21:26');
/* system_user3 */
INSERT INTO `user_general_info` (`id`, `user_type`, `user_name`, `email`, `password`, `family_name`, `last_name`, `mobile`, `telephone`, `location`, `birthday`, `head_thumb`, `begin_time`, `gender`, `salt`, `register_check_state`, `authentication_stat`, `ct`, `ut`) VALUES (6,0,'a1','a1@163.com','aa52864d7252d01f460de82cc2f6f142d7fe24cadc46f6f2d45022c54d85d5db','a1','a1','13412341234',NULL,NULL,'2015-06-10 21:54:46',NULL,'2015-06-10 21:54:46',NULL,'1bb87a2bcec343ca9dff4a9944d514a8',1,0,'2015-06-10 21:54:46','2015-06-10 21:54:46');
/* system_user4 */
INSERT INTO `user_general_info` (`id`, `user_type`, `user_name`, `email`, `password`, `family_name`, `last_name`, `mobile`, `telephone`, `location`, `birthday`, `head_thumb`, `begin_time`, `gender`, `salt`, `register_check_state`, `authentication_stat`, `ct`, `ut`) VALUES (7,1,'abc1','abc1@163.com','562b8680096aa8da3783f98fcaf60391749ba9d4f03d13dbabb239ddb523a230',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-10 23:18:30',NULL,'2a7fdca3a8fb40cfb8b828f24753bee3',1,0,'2015-06-10 23:18:30','2015-06-10 23:18:30');
/* system_user5 */
INSERT INTO `user_general_info` (`id`, `user_type`, `user_name`, `email`, `password`, `family_name`, `last_name`, `mobile`, `telephone`, `location`, `birthday`, `head_thumb`, `begin_time`, `gender`, `salt`, `register_check_state`, `authentication_stat`, `ct`, `ut`) VALUES (8,2,'abc2','abc2@163.com','6fce48077422605b21334730cfbad625d6e4da6b55cf135f5eb3b793daea84dc',NULL,NULL,'12312341234',NULL,NULL,NULL,NULL,'2015-06-10 23:43:33',NULL,'4efa4ce01c5146108373a92ba1e59c68',2,0,'2015-06-10 23:43:33','2015-06-10 23:46:39');
/* dic_place1 */
INSERT INTO `dic_place` (`id`, `placeName`, `pid`, `placeType`, `about`, `ispub`) VALUES ('1', '境外', '0', '1', '境外', '0');
/* dic_place2 */
INSERT INTO `dic_place` (`id`, `placeName`, `pid`, `placeType`, `about`, `ispub`) VALUES ('2', '境内', '0', '2', '境内', '0');
