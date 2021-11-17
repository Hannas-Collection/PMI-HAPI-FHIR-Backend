package ca.uhn.fhir.jpa.starter;

//import ca.uhn.fhir.context.FhirContext;
//import ca.uhn.fhir.jpa.rp.r4.ObservationResourceProvider;
//import ca.uhn.fhir.jpa.starter.ResourceProvider.PatientResourceProviderOld;
//import ca.uhn.fhir.rest.server.IResourceProvider;
import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.jpa.rp.r4.ObservationResourceProvider;
import ca.uhn.fhir.jpa.rp.r4.PatientResourceProvider;
import ca.uhn.fhir.rest.server.IResourceProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

import javax.servlet.ServletException;
import java.util.ArrayList;
import java.util.List;

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
	  /**
		* @since 16.11.2021
		*/
	  setFhirContext(FhirContext.forR4()); //Verwendung der FHIR Spezifikation R4

	  List<IResourceProvider> resourceProviders = new ArrayList<IResourceProvider>();
	  resourceProviders.add(new PatientResourceProvider());
	  resourceProviders.add(new ObservationResourceProvider());
	  setResourceProviders(resourceProviders);
  }

}