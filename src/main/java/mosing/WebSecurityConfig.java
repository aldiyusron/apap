package mosing;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	DataSource dataSource;
		
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/").permitAll()
				.antMatchers("/lihat-hasil").permitAll()
				.antMatchers("/register").permitAll()
				.antMatchers("/register/**").permitAll()
				.antMatchers("/forgotPassword").permitAll()
				.antMatchers("/resetPassword").permitAll()
				.antMatchers("/resetPassword/**").permitAll()
				.antMatchers("/static/**").permitAll()
				.antMatchers("/css/**").permitAll()
				.antMatchers("/img/**").permitAll()
				.antMatchers("/js/**").permitAll()
				.antMatchers("/fonts/**").permitAll()
				.antMatchers("/font-awesome/**").permitAll()
				.antMatchers("/pendaftar/**").hasRole("PEND").anyRequest().authenticated()
				.antMatchers("/daftar-siswa").hasRole("LPT").anyRequest().authenticated()
				.antMatchers("/data-pendaftar").hasRole("LPT").anyRequest().authenticated()
				.antMatchers("/data-pendaftar/**").hasRole("LPT").anyRequest().authenticated()
				.antMatchers("/LPT/**").hasRole("LPT").anyRequest().authenticated()
				.antMatchers("/detail-siswa/**").hasRole("LPT").anyRequest().authenticated()
				.antMatchers("/nilai-ips/**").hasRole("LPT").anyRequest().authenticated()
				.antMatchers("/nilai-ipa/**").hasRole("LPT").anyRequest().authenticated()
				.antMatchers("/jalur-masuk/**").hasRole("KPMB").anyRequest().authenticated()
				.antMatchers("/lokasi-ujian/**").hasRole("KPMB").anyRequest().authenticated()
				.antMatchers("/prodi-tersedia/**").hasRole("KPMB").anyRequest().authenticated()
				.antMatchers("/dashboard").hasRole("PEM_U").anyRequest().authenticated()
				.antMatchers("/dashboard/**").hasRole("PEM_U").anyRequest().authenticated()
				.antMatchers("/dashboard").hasRole("PEM_F").anyRequest().authenticated()
				.antMatchers("/dashboard/**").hasRole("PEM_F").anyRequest().authenticated()
				.antMatchers("/pengawas/**").hasRole("PENG_U").anyRequest().authenticated()
				.antMatchers("/sukses-pengawas/**").hasRole("PENG_U").anyRequest().authenticated()
				.antMatchers("/seleksi-pendaftar").hasRole("PEM_U").anyRequest().authenticated()
				.antMatchers("/sukses-seleksi").hasRole("PEM_U").anyRequest().authenticated()
				.antMatchers("/lihat/**").hasRole("PEM_U").anyRequest().authenticated()
				.antMatchers("/acceptPendaftar").hasRole("PEM_F").anyRequest().authenticated()
				.antMatchers("/view/**").hasRole("PEM_F").anyRequest().authenticated()
				.antMatchers("/sukses-rekomendasi").hasRole("PEM_F").anyRequest().authenticated()
				.anyRequest().authenticated().and().formLogin()
				
				.loginPage("/login").defaultSuccessUrl("/").permitAll().and().logout().permitAll();
	}
	
	@Autowired
	public void configAuthentication(AuthenticationManagerBuilder auth) throws Exception {
		auth.jdbcAuthentication().dataSource(dataSource)
				.usersByUsernameQuery("SELECT username, password, enabled FROM USER WHERE username=?")
				.authoritiesByUsernameQuery("SELECT username, role FROM USER WHERE username=?");
	}
}
