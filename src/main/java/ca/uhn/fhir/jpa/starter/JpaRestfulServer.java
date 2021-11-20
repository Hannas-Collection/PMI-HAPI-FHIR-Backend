package ca.uhn.fhir.jpa.starter;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.jpa.starter.resourceProviders.QuestionnaireResourceProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

import javax.servlet.ServletException;
import java.util.Arrays;

@Import(AppProperties.class)
public class JpaRestfulServer extends BaseJpaRestfulServer {

  @Autowired
  AppProperties appProperties;

  private static final long serialVersionUID = 1L;

  public JpaRestfulServer() {
    super();
  }

  @Override
  protected void initialize() throws ServletException {
    super.initialize();

    // Add your own customization here
	  setFhirContext(FhirContext.forR4()); // R4 Spezifikation

//	  setResourceProviders(Arrays.asList(
//		  myApplicationContext.getBean(QuestionnaireResourceProvider.class),
//		  myApplicationContext.getBean(QuestionnaireResourceProvider.class))
//	  ); // holt die resource providers für den Server

  }

}
