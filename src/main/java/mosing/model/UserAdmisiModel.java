<<<<<<< HEAD
package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserAdmisiModel  {

	public UserAdmisiModel(String username2, String password2, String email2, String string) {
		// TODO Auto-generated constructor stub
	}
	private String username;
	private String password;
	private String email;
	private String role;
	
	public UserAdmisiModel(String username2, String password2, String email2, String role) {
		username = username2;
		password = password2;
		email = email2;
		this.role = role;
		// TODO Auto-generated constructor stub
	}
}
=======
package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserAdmisiModel  {

	private String username;
	private String password;
	private String email;
	private String role;
}
>>>>>>> branch 'master' of https://github.com/propensi2017/a6.git
