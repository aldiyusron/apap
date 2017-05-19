package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import mosing.model.UserAdmisiModel;

@Mapper
public interface UserAdmisiMapper {

	@Select("SELECT * FROM USER WHERE username = #{username}")
	@Results(value = { @Result(property = "username", column = "username"),
			@Result(property = "password", column = "password"), @Result(property = "email", column = "email"),
			@Result(property = "role", column = "role") })
	UserAdmisiModel selectUser(@Param("username") String username);

	@Insert("INSERT INTO USER (username, password, email, role, enabled) VALUES (#{username}, #{password}, #{email}, #{role}, 1)")
	void addUser(UserAdmisiModel user);
	
	@Update("UPDATE USER SET password = #{password} WHERE username = #{username}")
	void updateUser(UserAdmisiModel user);
	
	@Select("SELECT * FROM USER")
	List<UserAdmisiModel> selectAllUser();
}