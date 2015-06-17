package com.starlighting.lvpaiweb.bean;

/**
 * Created by spring on 15-3-19.
 */
public enum UserTypeEnum {

	//		1会员
//		2摄影师
//		3造型师
//		4摄影机构管理员
	ADMIN("管理员",0,"customerAccountService","SELECT USER_TYPE, USER_NAME, EMAIL email, PASSWORD password," +
			"  (CASE  WHEN USER_TYPE=1 THEN '会员'  WHEN USER_TYPE=2 THEN '摄影师' WHEN USER_TYPE=3 THEN '造型师' ELSE '摄影机构管理员' END) USERTYPENAME,"+
			" FAMILY_NAME , LAST_NAME , MOBILE mobile, TELEPHONE telephone, LOCATION location, BIRTHDAY birthday, " +
			"HEAD_THUMB , " +
			"ADD_TIME , BEGIN_TIME ,ID id," +
			"user_general_info_id ,signature,destination,remark,GENDER,(CASE WHEN GENDER = 0 THEN '男' ELSE '女' END) GENDERNAME " +
			" FROM user_general_info g, customer_extra c " +
			"WHERE g.user_type = 1  and g.id = c.user_general_info_id and  user_name = :USER_NAME and password = :PASSWORD"),

	CUSTOMER("会员",1,"customerAccountService","SELECT USER_TYPE, USER_NAME, EMAIL email, PASSWORD password," +
			"  (CASE  WHEN USER_TYPE=1 THEN '会员'  WHEN USER_TYPE=2 THEN '摄影师' WHEN USER_TYPE=3 THEN '造型师' ELSE '摄影机构管理员' END) USERTYPENAME,"+
			" FAMILY_NAME , LAST_NAME , MOBILE mobile, TELEPHONE telephone, LOCATION location, BIRTHDAY birthday, " +
			"HEAD_THUMB , " +
			"ADD_TIME , BEGIN_TIME ,ID id," +
			"user_general_info_id ,signature,destination,remark,GENDER,(CASE WHEN GENDER = 0 THEN '男' ELSE '女' END) GENDERNAME " +
			" FROM user_general_info g, customer_extra c " +
			"WHERE g.user_type = 1  and g.id = c.user_general_info_id and  user_name = :USER_NAME and password = :PASSWORD"),
	PHOTOGRAPHER("摄影师",2,"photographerAccountService",
			"SELECT USER_TYPE , USER_NAME , EMAIL email, PASSWORD password, FAMILY_NAME, LAST_NAME ," +
					"  (CASE  WHEN USER_TYPE=1 THEN '会员'  WHEN USER_TYPE=2 THEN '摄影师' WHEN USER_TYPE=3 THEN '造型师' ELSE '摄影机构管理员' END) USERTYPENAME,"+
					" MOBILE mobile, TELEPHONE telephone, LOCATION location, BIRTHDAY birthday, HEAD_THUMB , " +
			"ADD_TIME , BEGIN_TIME ,ID id," +
			"user_general_info_id ," +
			"introduction,\n" +
			"authentication,\n" +
			"certificate_type ,\n" +
			"certificate_num ,\n" +
			"idcard_front ,\n" +
			"idcard_back ,\n" +
			"deposit,\n" +
			"remark,\n" +
			"register_check_state,authentication_stat,GENDER,(CASE WHEN GENDER = 0 THEN '男' ELSE '女' END) GENDERNAME  " +
			" FROM user_general_info g, photographer_extra c " +
			"WHERE g.user_type = 2    and g.id = c.user_general_info_id and user_name = :USER_NAME and password = :PASSWORD"),
	STYLIST("造型师",3,"stylistAccountService",
			"SELECT USER_TYPE , USER_NAME, EMAIL email, PASSWORD password, FAMILY_NAME , LAST_NAME , MOBILE mobile," +
					"  (CASE  WHEN USER_TYPE=1 THEN '会员'  WHEN USER_TYPE=2 THEN '摄影师' WHEN USER_TYPE=3 THEN '造型师' ELSE '摄影机构管理员' END) USERTYPENAME,"+
					" TELEPHONE telephone, LOCATION location, BIRTHDAY birthday, HEAD_THUMB , " +
			"ADD_TIME , BEGIN_TIME ,ID id," +
			"user_general_info_id ,introduction,\n" +
			"authentication,\n" +
			"certificate_type ,\n" +
			"certificate_num ,\n" +
			"idcard_front ,\n" +
			"idcard_back ,\n" +
			"deposit,\n" +
			"remark,\n" +
			"register_check_state,authentication_stat,GENDER,(CASE WHEN GENDER = 0 THEN '男' ELSE '女' END) GENDERNAME  " +
			" FROM user_general_info g, stylist_extra c " +
			"WHERE g.user_type = 3    and g.id = c.user_general_info_id and user_name = :USER_NAME and password = :PASSWORD"),
	AGENCY("摄影机构管理员",4,"agencyAccountService",
			"SELECT USER_TYPE , USER_NAME , EMAIL email, PASSWORD password, FAMILY_NAME , " +
					"  (CASE  WHEN USER_TYPE=1 THEN '会员'  WHEN USER_TYPE=2 THEN '摄影师' WHEN USER_TYPE=3 THEN '造型师' ELSE '摄影机构管理员' END) USERTYPENAME,"+
					"LAST_NAME lastName, MOBILE mobile, TELEPHONE telephone, LOCATION location, BIRTHDAY birthday, HEAD_THUMB , " +
			"ADD_TIME , BEGIN_TIME ,ID id," +
			"user_general_info_id ,authentication,\n" +
			"certificate_type ,\n" +
			"certificate_num ,\n" +
			"idcard_front ,\n" +
			"idcard_back ,\n" +
			"remark,\n" +
			"deposit,\n" +
			"introduction,\n" +
			"photographer_desc ,\n" +
			"stylist_desc ,\n" +
			"dress_desc ,\n" +
			"address,\n" +
			"register_check_state,authentication_stat,GENDER,(CASE WHEN GENDER = 0 THEN '男' ELSE '女' END) GENDERNAME  " +
			" FROM user_general_info g, agency_extra c " +
			"WHERE g.user_type = 4   and  g.id = c.user_general_info_id and user_name = :USER_NAME and password = :PASSWORD")
			;
	//资源编码
	private Integer code;
	//资源名称
	private String name;

	private String daoClassName;

	private String loginSql;

	private UserTypeEnum(String name, Integer code, String daoClassName, String loginSql) {
		this.code = code;
		this.name = name;
		this.daoClassName = daoClassName;
		this.loginSql = loginSql;
	}
	public static UserTypeEnum getUserTypeEnum(Integer code) {
		for (UserTypeEnum c : UserTypeEnum.values()) {
			if (c.getCode() == code) {
				return c;
			}
		}
		return CUSTOMER;
	}


	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDaoClassName() {
		return daoClassName;
	}

	public void setDaoClassName(String daoClassName) {
		this.daoClassName = daoClassName;
	}

	public String getLoginSql() {
		return loginSql;
	}

	public void setLoginSql(String loginSql) {
		this.loginSql = loginSql;
	}
}
