import java.io.File;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFTextStripper;
//import org.apache.pdfbox.searchengine.lucene.LucenePDFDocument;


public class Main {

	public static void main(String[] args) throws Exception{
		PDFTextStripper stripper = new PDFTextStripper();
		System.out.println(stripper);
		File file = new File("elastandards1.pdf");
		PDDocument doc = PDDocument.load(file);
		System.out.println(doc);
		String text = stripper.getText(doc);
		System.out.println(text);
	}

}
