package mosing.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import mosing.model.UserAdmisiModel;

public interface UserAdmisiMapper {
	@Select("select username, role from user where username = #{username}")
    @Results(value = {
        @Result(property="username", column="username"),
        @Result(property="role", column="role")
    })
    UserAdmisiModel selectUser (@Param("username") String username);
}
