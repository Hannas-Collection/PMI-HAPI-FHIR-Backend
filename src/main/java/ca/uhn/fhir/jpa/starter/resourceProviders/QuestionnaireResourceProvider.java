package ca.uhn.fhir.jpa.starter.resourceProviders;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.annotation.Create;
import ca.uhn.fhir.rest.annotation.IdParam;
import ca.uhn.fhir.rest.annotation.Read;
import ca.uhn.fhir.rest.annotation.ResourceParam;
import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.server.IResourceProvider;
import ca.uhn.fhir.rest.server.exceptions.UnprocessableEntityException;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.IdType;
import org.hl7.fhir.r4.model.Questionnaire;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class QuestionnaireResourceProvider implements IResourceProvider {
	/**
	 * Returns the type of resource returned by this provider
	 *
	 * @return Returns the type of resource returned by this provider
	 */
	@Override
	public Class<? extends IBaseResource> getResourceType() {
		return Questionnaire.class;
	}

	@Qualifier("fhirContextR4")
	@Autowired
	private FhirContext fhirContext;

	@Create
	public MethodOutcome createQuestion(@ResourceParam Questionnaire questionnaire) {
		if (questionnaire.getIdentifierFirstRep().isEmpty()) {
			throw new UnprocessableEntityException("No identifier supplied");
		}

		MethodOutcome methodOutcome = new MethodOutcome();
		methodOutcome.setId(new IdType("Questionaire", "1", "1.0"));

		return methodOutcome;
	}

	@Read
	public Questionnaire getQuestionResourceById(@IdParam IdType idType) {
		Questionnaire questionnaire = new Questionnaire();
		questionnaire.addIdentifier().setSystem("urn:mrns").setValue("123456");
		return questionnaire;
	}

}
