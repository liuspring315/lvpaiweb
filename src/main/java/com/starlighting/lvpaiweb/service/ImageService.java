package com.starlighting.lvpaiweb.service;

import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.img.Images;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by spring on 2015/8/13.
 */
@IocBean
public class ImageService {
    @Inject
    protected Dao dao;
    @Inject("java:$config.get('img.path')")
    private String imgPath;

    public byte[] getImg(final String filedName,String tableName,String condition,Integer id) {
        String path = imgPath + tableName + File.separator + filedName + File.separator;
        File filePath= new File(path);
        if(!filePath.exists() ){
            filePath.mkdirs();
        }
        File file=new File(path + id.intValue() + ".jpg");
        if(!file.exists() ){
            Sql sql = Sqls.create("SELECT "+filedName+" FROM "+tableName+" WHERE "+condition + "=" + id);
            sql.setCallback(new SqlCallback() {
                public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
                    if (rs.next())
                        return (rs.getBytes(filedName));
                    return null;
                }
            });
            dao.execute(sql);
            byte[] img =  (byte[])sql.getResult();
            if(img != null) {
                InputStream sbs = new ByteArrayInputStream(img);
                BufferedImage image = Images.read(sbs);
                Images.writeJpeg(image, file, 1.0f);
            }else{
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                Images.writeJpeg(Images.read(new File(imgPath + "rs/user_avatar/none.jpg")), out, 1.0f);
                return out.toByteArray();
            }
        }
        try {
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            Images.writeJpeg(Images.read(file), out, 1.0f);
            return out.toByteArray();
        }catch (Exception e){
            return null;
        }

    }


    public void removeImg(final String filedName,String tableName,Long id) {
        String path = imgPath + tableName + File.separator + filedName + File.separator;
        File file = new File(path + id.longValue() + ".jpg");
        if (file.exists()) {
            file.delete();
        }
    }

}
