package mosing.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NilaiUjianModel {

	private int no_daftar;
	private int tpa;
	private int mtk_dasar;
	private int mtk;
	private int kimia;
	private int fisika;
	private int biologi;
	private int sejarah;
	private int geografi;
	private int ekonomi;
	private int sosiologi;
	private int bindo;
	private int bing;
}
