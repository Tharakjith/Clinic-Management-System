import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Registration } from '../model/registration';
import { Role } from '../model/role';
import { Staff } from '../model/staff';
import { Doctors } from '../model/doctors';
import { Specialization } from '../model/specialization';

@Injectable({
  providedIn: 'root'
})
export class DmanagementService {
  registration: Registration[] = [];
  staff: Staff[] = [];
  role: Role[] = [];
  specilization: Specialization[] = [];
  formStaffData: Doctors = new Doctors();
   doctors:Doctors[] =[];

  constructor(private httpClient: HttpClient) {}
///1- Get All Employees
getAlldoctors(): void {
  this.httpClient.get(environment.apiUrl + 'Doctors')

    .toPromise()
    .then((response?: any) => {
      if (response.Value) {
        this.doctors = response.Value;
        console.log(this.doctors);
      }
    })
    .catch((error) => {
      console.log('Error occured:', error);
    });
}


insertdoctors(doctors: Doctors): Observable<any> {
console.log("Insert: In Service");
console.log(doctors);
return this.httpClient.post(environment.apiUrl + 'Doctors/register', doctors);
}


// 3. Get all departments
getAllSpecilization(): void {
  this.httpClient.get(environment.apiUrl + 'Doctors/v2')
    .toPromise()
    .then((response?: any) => {
      if (response.Value) {
        this.specilization= response.Value;
        console.log(this.specilization);
      }
    })
    .catch((error) => {
      console.log('Error occured:', error);
    });
}


// 3. Get all departments
getAllstaff(): void {
  this.httpClient.get(environment.apiUrl + 'Doctors/v6')
    .toPromise()
    .then((response?: any) => {
     
      if (response.Value) {
        this.staff = response.Value;
        console.log(this.staff);
      } 
    })
    .catch((error) => {
      console.log('Error occurred while fetching roles:', error);
    });
}


getAllusers(): void {
  this.httpClient.get(environment.apiUrl + 'Doctors/v5')
    .toPromise()
    .then((response?: any) => {
     
      if (response.Value) {
        this.registration = response.Value;
        console.log(this.registration);
      } 
    })
    .catch((error) => {
      console.log('Error occurred while fetching roles:', error);
    });
}

// 4. Update a staff
Updateusers(doctors:Doctors):Observable<any>{
  console.log("Update : In service");
  return this.httpClient.put(environment.apiUrl+'Doctors/'+doctors.DoctorId,doctors);
}

// 5. Delete a doctor
deleteDoctor(id: number): Observable<any> {
  return this.httpClient.delete(environment.apiUrl + 'Doctors/' + id);
}
}