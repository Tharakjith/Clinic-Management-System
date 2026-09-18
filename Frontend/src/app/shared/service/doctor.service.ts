import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { StartDiagnosy } from '../model/start-diagnosy';
import { AppoinmentpatientViewmodel } from '../model/appoinmentpatient-viewmodel';


import { Appointment } from '../model/appointment';
import { Doctors } from '../model/doctors';


@Injectable({
  providedIn: 'root'
})
export class DoctorService {
  
  //declare some variables
  //List of Employees
  startDiagnosys: StartDiagnosy[] = [];
  doctors:Doctors[]=[];
  formDiagnosysData: StartDiagnosy= new StartDiagnosy();
  appoitnment: Appointment[] = [];
  appoinmentpatientViewmodel: AppoinmentpatientViewmodel[] = [];
  formappoinment: AppoinmentpatientViewmodel = new AppoinmentpatientViewmodel();
  DateOfJoining: any;
  DiagnosysDate:any;


  //DI:HTTP CLIENT

  constructor(private httpClient: HttpClient) { }

  //1-Get all Employees
  getAllAppoinment(): void {
    this.httpClient.get(environment.apiUrl + 'viewPatientAppoinment/todaysAppointments/{doctorId}')
      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.appoinmentpatientViewmodel = response.Value;
          console.log(this.appoinmentpatientViewmodel);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  }
   
  

  getTodaysAppointments(doctorId: number): Observable<AppoinmentpatientViewmodel[]> {
    return this.httpClient.get<AppoinmentpatientViewmodel[]>(
      `${environment.apiUrl}viewPatientAppoinment/todaysAppointments/${doctorId}`
    );
  }

//1-Get all Diagnosys
  getAllDoctors(): void {
    this.httpClient.get(environment.apiUrl + 'StartDiagnosys/Doctors')
      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.doctors = response.Value;
          console.log(this.doctors);
        }
      })
      .catch((error) => {
        console.log('Error Occured : ',error);
      });
  }
  getAllDiagnosys(): void {
    this.httpClient.get(environment.apiUrl + 'StartDiagnosys')
      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.startDiagnosys = response.Value;
          console.log(this.startDiagnosys);
        }
      })
      .catch((error) => {
        console.log('Error Occured : ',error);
      });
  }

//Insert Employee
insertDiagnosys(startDiagnosys:StartDiagnosy): Observable<any>{
  console.log("Insert In service ");
  return this.httpClient.post(environment.apiUrl + 'StartDiagnosys',startDiagnosys);
   }
 //4 - Update an Employee
 editDiagnosys( startDiagnosy: StartDiagnosy): Observable<any> {
  console.log("Update: In service");
  return this.httpClient.put(environment.apiUrl + 'StartDiagnosys/' + startDiagnosy.HistoryId, startDiagnosy);
 }

 // 5 - Delete Diagnosis
 deleteDiagnosys(id: number): Observable<any> {
  return this.httpClient.delete(environment.apiUrl + 'StartDiagnosys/' + id);
 }
}

