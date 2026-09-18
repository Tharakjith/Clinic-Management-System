import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Observable, throwError } from 'rxjs';
import { doesNotReject } from 'node:assert';
import { Doctors } from '../model/doctors';
import { User } from '../model/user';
import { Specialization } from '../model/specialization';
import { Staff } from '../model/staff';


@Injectable({
  providedIn: 'root'
})
export class DoctormanagementService {
  doctor: Doctors[] = [];
  user: User[] = [];
  staff: Staff[] = [];
  specialization: Specialization[] = [];
  formdoctorData: Doctors = new Doctors();

  RegisteredDate: any;

  constructor(private httpClient: HttpClient) { }
  ///1- Get All doctors
  getAllDoctors(): void {
    this.httpClient.get(environment.apiUrl + 'Doctors')

      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.doctor = response.Value;
          console.log(this.doctor);
        }
      })
      .catch((error) => {
        console.log('Error occured:', error);
      });
  }
  // 2- Insert doctor
  insertDoctors(doctor: Doctors): Observable<any> {
    console.log("Insert: In Service");
    console.log(doctor);
    return this.httpClient.post(environment.apiUrl + 'Doctors', doctor);
  }

  // 3. Get all specialization
  getAllSpecialization(): void {
    this.httpClient.get(environment.apiUrl + 'Doctors/v2')
      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.specialization = response.Value;
          console.log(this.specialization);
        }
      })
      .catch((error) => {
        console.log('Error occured:', error);
      });
  }

  // 3. Get all specialization
  getAllstaffname(): void {
    this.httpClient.get(environment.apiUrl + 'Doctors/v5')
      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.user = response.Value;
          console.log(this.user);
        }
      })
      .catch((error) => {
        console.log('Error occured:', error);
      });
  }


  // 4. Update a doctor
  Updatedoctors(doctor: Doctors): Observable<any> {
    console.log("Update : In service");
    return this.httpClient.put(environment.apiUrl + 'Doctors/' + doctor.DoctorId, doctor);
  }
}




