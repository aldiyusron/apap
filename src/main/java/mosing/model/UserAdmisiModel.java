package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserAdmisiModel  {

	private String id_user;
	private String username;
	private String password;
	private String email;
	private String role;

}
