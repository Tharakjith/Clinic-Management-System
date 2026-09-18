import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Registration } from '../model/registration';
import { Role } from '../model/role';
import { Staff } from '../model/staff';

@Injectable({
  providedIn: 'root'
})
export class RegistrationService {
registration: Registration[] = [];
  staff: Staff[] = [];
  role: Role[] = [];
  formStaffData: Registration = new Registration();

 
  createdDate: any;
  
  constructor(private httpClient: HttpClient) {}

  ///1- Get All Employees
  getAllusers(): void {
    this.httpClient.get(environment.apiUrl + 'Registrations')

      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.registration = response.Value;
          console.log(this.registration);
        }
      })
      .catch((error) => {
        console.log('Error occured:', error);
      });
  }


insertUsers(registration: Registration): Observable<any> {
  console.log("Insert: In Service");
  console.log(registration);
  return this.httpClient.post(environment.apiUrl + 'Registrations', registration);
}


  // 3. Get all departments
  getAllStaffs(): void {
    this.httpClient.get(environment.apiUrl + 'Registrations/v2')
      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.staff= response.Value;
          console.log(this.staff);
        }
      })
      .catch((error) => {
        console.log('Error occured:', error);
      });
  }
  

  // 3. Get all departments
  getAllRoles(): void {
    this.httpClient.get(environment.apiUrl + 'Registrations/v5')
      .toPromise()
      .then((response?: any) => {
       
        if (response.Value) {
          this.role = response.Value;
          console.log(this.role);
        } 
      })
      .catch((error) => {
        console.log('Error occurred while fetching roles:', error);
      });
  }
  
  // 4. Update a staff
  Updateusers(registration:Registration):Observable<any>{
    console.log("Update : In service");
    return this.httpClient.put(environment.apiUrl+'Registrations/'+registration.RegistrationId,registration);
  }

  // 5. Delete a user
  deleteUser(id: number): Observable<any> {
    return this.httpClient.delete(environment.apiUrl + 'Registrations/' + id);
  }
}