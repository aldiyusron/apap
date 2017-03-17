package mosing.mapper;


import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import mosing.model.UserAdmisiModel;

@Mapper
public interface UserAdmisiMapper {
	@Select("select username from user where username = #{username}")
    @Results(value = {
        @Result(property="username", column="username"),
        @Result(property="password", column="password"),
        @Result(property="email", column="email"),
        @Result(property="role", column="role")
    })
    UserAdmisiModel selectUser (@Param("username") String username);
	
	@Insert("INSERT INTO user (username, password, email, role) VALUES"
			+ "(#{username}, #{password}, #{email}, #{role}")
	void addUser(UserAdmisiModel user);
}