package ca.uhn.fhir.jpa.starter.ResourceProvider;

import ca.uhn.fhir.rest.server.IResourceProvider;
import org.hl7.fhir.instance.model.api.IBaseResource;

/**
 * @since 16.11.2021
 */
public class PatientResourceProvider implements IResourceProvider {

	/**
	 * Returns the type of resource returned by this provider
	 *
	 * @return Returns the type of resource returned by this provider
	 */
	@Override
	public Class<? extends IBaseResource> getResourceType() {
		return null;
	}
}
