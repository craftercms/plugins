package scripts.plugins.profile

import java.util.List


/**
 * Class allows system to interact with the user profile in a standard way regardless of the backend
 */
public class UserProfile {
    String crafterProfileId = null
    String userName = null
    String firstName = null
    String lastName = null
    String email = null
    String preferredName = null
    String officePhone = null
    String mobilePhone = null
    String skypeId = null
    String linkedInId = null

    UserProfile(userName, firstName, lastName, email) {
        this.userName = userName
        this.firstName = firstName
        this.lastName = lastName
        this.email = email
    }

    String getUserName() {
        return this.userName
    }

    String getFirstName() {
        return this.firstName
    }

    String getLastName() {
        return this.lastName
    }

   /** Attributes **/
    String getCrafterProfileId() { return this.crafterProfileId }
    void setCrafterProfileId(String value) { this.crafterProfileId = value }

    String getTitle() { return this.title }
    void setTitle(String value) { this.title = value }

    String getPreferredName() { return this.preferredName }
    void setPreferredName(String value) { this.preferredName = value }

    String getOfficePhone() { return this.officePhone }
    void setOfficePhone(String value) { this.officePhone = value }

    String getMobilePhone() { return this.mobilePhone }
    void setMobilePhone(String value) { this.mobilePhone = value }

    String getSkypeId() { return this.skypeId }
    void setSkypeId(String value) { this.skypeId = value }

    String getLinkedInId() { return this.linkedInId }
    void setLinkedInId(String value) { this.linkedInId = value }
}






