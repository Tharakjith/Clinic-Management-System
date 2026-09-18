import { Injectable } from '@angular/core';
import { Patient } from '../model/patient';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { catchError, map, Observable, of } from 'rxjs';
import { Specialization } from '../model/specialization';
import { Doctors } from '../model/doctors';
import { Availability } from '../model/availability';
import { Appointment } from '../model/appointment';
import { Doctorbyspectn } from '../model/doctorbyspectn';

@Injectable({
  providedIn: 'root'
})
export class PatientService {

  //List of patients
  patients: Patient[] = [];
  specializations: Specialization[] = [];
  doctors: Doctors[] = [];
  doctorspec : Doctorbyspectn[] = [];
  availabilities: Availability[] = [];
  frmAppointment: Appointment = new Appointment();
  formPatientData: Patient = new Patient();

  //Dob: any;

  constructor(private httpClient: HttpClient) { }

  // Get All Patients
  getAllPatients(): void {
    this.httpClient.get(environment.apiUrl + 'receptions')
      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.patients = response.Value;
          console.log(this.patients);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  }

  // Insert a new Patient
  insertPatient(patient: Patient): Observable<any> {
    console.log("Insert: In service"); // https://localhost:7201/api/receptions
    return this.httpClient.post(environment.apiUrl + 'receptions', patient);
  }

  // Update an existing Patient
  updatePatient(patient: Patient): Observable<any> {
    console.log("Update: In service");
    return this.httpClient.put(environment.apiUrl + 'receptions/' + patient.PatientId, patient);
  }

  // Delete a Patient
  deletePatient(id: number): Observable<any> {
    return this.httpClient.delete(environment.apiUrl + 'receptions/' + id);
  }

  //Specializations
  getAllSpecializations(): Observable<Specialization[]> {
    return this.httpClient.get<any>(`${environment.apiUrl}receptions/specializations`).pipe(
      map((response: any) => response.Value || []), // Extract 'Value'
      catchError((error) => {
        console.error('Error fetching specializations:', error);
        return of([]); // Return an empty array on error
      })
    );
  }

  // getDoctorsBySpecialization(specializationId: number): Observable<Doctors[]> {
  //   return this.httpClient.get<Doctors[]>
  //   (`${environment.apiUrl}receptions/Doctors/${specializationId}`);
  // }
  getDoctorsBySpecialization(specializationId: number): Observable<Doctorbyspectn[]> {
    return this.httpClient.get<any[]>(`${environment.apiUrl}receptions/Doctors/${specializationId}`).pipe(
      map((response) => {
        // Map API response to the Doctors model
        return response.map((doc) => {
          const doctorspeci = new Doctorbyspectn();
          doctorspeci.DoctorId = doc.DoctorId;
          doctorspeci.users.Staff.StaffName = doc.DoctorName; // Map DoctorName to StaffName
          doctorspeci.specialization.SpecializationName = doc.SpecializationName; // SpecializationName
          doctorspeci.ConsultationFee = doc.ConsultationFee;
          return doctorspeci;
        });
      }),
      catchError((error) => {
        console.error('Error fetching doctors:', error);
        return of([]); // Return an empty array on error
      })
    );
  }
  

  getDoctorAvailability(doctorId: number): Observable<any[]> {
    return this.httpClient.get<any>(`${environment.apiUrl}receptions/DoctorAvailability/${doctorId}`).pipe(
      map((response: any) => response?.value || response?.Value || (Array.isArray(response) ? response : [])),
      catchError((error) => {
        console.error('Error fetching doctor availability:', error);
        return of([]);
      })
    );
  }

  getConsultationFeeByDoctorId(doctorId: number): Observable<number> {
    return this.httpClient.get<number>(`${environment.apiUrl}receptions/doctor/${doctorId}/consultation-fee`).pipe(
      catchError(() => of(0))
    );
  }

  generateToken(doctorId: number, appointmentDate: string, timeSlotId: number): Observable<number> {
    return this.httpClient.get<any>(`${environment.apiUrl}receptions/generatetoken/${doctorId}/${appointmentDate}/${timeSlotId}`).pipe(
      map((res: any) => {
        if (typeof res === 'number') return res;
        if (res && res.tokenNumber !== undefined) return Number(res.tokenNumber);
        if (res && res.TokenNumber !== undefined) return Number(res.TokenNumber);
        return Number(res) || 1;
      }),
      catchError((error) => {
        console.error('Error generating token:', error);
        return of(1);
      })
    );
  }

  bookAppointment(appointment: Appointment): Observable<any> {
    return this.httpClient.post(`${environment.apiUrl}receptions/Bookappointment`, appointment);
  }
}
