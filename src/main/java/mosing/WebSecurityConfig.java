package mosing;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	
	
	@Autowired
	DataSource dataSource;
	
	
	@Autowired
	public void configAuthentication(AuthenticationManagerBuilder auth) throws Exception {
		auth.jdbcAuthentication().dataSource(dataSource)
				.passwordEncoder(passwordEncoder())
				.usersByUsernameQuery("select username, password, flag from user where username=?")
				.authoritiesByUsernameQuery("select username, role from user where username=?");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		http.authorizeRequests().antMatchers("/**").permitAll()
				/*.antMatchers("/css/**").permitAll()
				.antMatchers("/img/**").permitAll()
				.antMatchers("/js/**").permitAll()
				.antMatchers("/plugins/**").permitAll()
				.antMatchers("/univ/**").permitAll()
				.antMatchers("/fakultas/**").permitAll()
				.antMatchers("/prodi/**").permitAll()
				.antMatchers("/register").permitAll()
				.antMatchers("/matakuliah/**").hasRole("SIAK")
				.antMatchers("/user/**").hasRole("SIAK")
				.antMatchers("/mahasiswa/**").hasRole("SIAK")
				.antMatchers("/kurikulum/**").hasRole("SIAK")
				.antMatchers("/term/**").hasRole("SIAK")
				.antMatchers("/prasyarat/**").hasRole("SIAK")
				.antMatchers("/irs/**").hasRole("SIAK")
				.antMatchers("/kelas/**").hasRole("SIAK")
				.antMatchers("/jadwal/**").hasRole("SIAK")
				.antMatchers("/kehadiran/**").hasRole("SIAK")
				*/
				.anyRequest().authenticated().and().formLogin()
				.loginPage("/login").permitAll().and().logout().permitAll();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder(){
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		return encoder;
	}


}