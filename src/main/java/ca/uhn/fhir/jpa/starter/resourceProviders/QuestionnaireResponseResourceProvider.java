package ca.uhn.fhir.jpa.starter.resourceProviders;

import ca.uhn.fhir.context.FhirContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class QuestionnaireResponseResourceProvider {

	@Qualifier("fhirContextR4")
	@Autowired
	private FhirContext fhirContext;
}
