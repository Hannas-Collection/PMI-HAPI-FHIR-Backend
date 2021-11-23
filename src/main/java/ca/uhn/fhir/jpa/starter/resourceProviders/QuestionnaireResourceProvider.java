package ca.uhn.fhir.jpa.starter.resourceProviders;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.annotation.*;
import org.hl7.fhir.r4.model.Questionnaire;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class QuestionnaireResourceProvider{

	@Qualifier("fhirContextR4")
	@Autowired
	private FhirContext fhirContext; //Fhir Context

	@Create
	public QuestionnaireResourceProvider createQuestion(@ResourceParam Questionnaire question) {
		QuestionnaireResourceProvider questionnaireResourceProvider = new QuestionnaireResourceProvider();
		questionnaireResourceProvider.createQuestion(question);
		return questionnaireResourceProvider;
	}

	@Read
	public QuestionnaireResourceProvider getQuestion(@IdParam IdParam theId) {
		QuestionnaireResourceProvider questionnaireResourceProvider = new QuestionnaireResourceProvider();
		questionnaireResourceProvider.getQuestion(theId);
		return questionnaireResourceProvider;
	}

	@Update
	public QuestionnaireResourceProvider updateQuestion(@ResourceParam Questionnaire question, @IdParam IdParam theId){
		return null;
	}

	@Search
	public QuestionnaireResourceProvider searchQuestion(){
		return null;
	}

}
