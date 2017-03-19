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
}
