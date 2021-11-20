package ca.uhn.fhir.jpa.starter.resourceProviders;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.server.IResourceProvider;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.QuestionnaireResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class QuestionnaireResponseResourceProvider implements IResourceProvider {
	/**
	 * Returns the type of resource returned by this provider
	 *
	 * @return Returns the type of resource returned by this provider
	 */
	@Override
	public Class<? extends IBaseResource> getResourceType() {
		return QuestionnaireResponse.class; //R4 Spezifikation
	}

	@Qualifier("fhirContextR4")
	@Autowired
	private FhirContext fhirContext;
}
