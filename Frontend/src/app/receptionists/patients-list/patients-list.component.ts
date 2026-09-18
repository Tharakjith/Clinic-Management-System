import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Patient } from 'src/app/shared/model/patient';
import { PatientService } from 'src/app/shared/service/patient.service';

@Component({
  selector: 'app-patients-list',
  templateUrl: './patients-list.component.html',
  styleUrls: ['./patients-list.component.scss']
})
export class PatientsListComponent implements OnInit {

  // Declare variables
  page: number = 1;
  pageSize: number = 5;
  searchTerm: string = '';
  searchPerformed: boolean = false; // Added this property
  isMessageShown: boolean = false;

  constructor(public patientService: PatientService, 
              private router: Router, 
              private toastr: ToastrService) { }

  ngOnInit(): void {
    console.log("Patient List Component");
    this.patientService.getAllPatients();
  }

  // Trigger Search
  onSearch(): void {
    this.searchPerformed = this.searchTerm.trim().length > 0;
  }

  // Filter Patients Based on Search
  filteredPatients(): Patient[] {
    if (!this.searchTerm.trim()) {
      return this.patientService.patients;
    }

    const searchTermLower = this.searchTerm.toLowerCase().trim();

    return this.patientService.patients.filter(e => {
      const patCode = `pc${e.PatientId}`.toLowerCase();
      return (
        e.PatientName?.toLowerCase().includes(searchTermLower) ||
        e.PatientPhone?.toLowerCase().includes(searchTermLower) ||
        patCode.includes(searchTermLower)
      );
    });
  }

  // Edit Patient
  editPatient(patient: Patient): void {
    this.populatePatientData(patient);
    this.router.navigate(['/patients/edit/' + patient.PatientId]);
  }

  // Book Appointment
  bookAppointment(patient: Patient): void {
    this.router.navigate(['/patients/book/', patient.PatientId]);
  }

  // Populate Patient Data
  populatePatientData(patient: Patient) {
    const datePipe = new DatePipe("en-UK");
    const formattedDate: any = datePipe.transform(patient.Dob, 'yyyy-MM-dd');
    patient.Dob = formattedDate;
    this.patientService.formPatientData = { ...patient };
  }

  // Delete Patient
  deletePatient(patient: Patient) {
    if (confirm(`Are you sure you want to delete patient record for '${patient.PatientName}'?`)) {
      this.patientService.deletePatient(patient.PatientId).subscribe(
        response => {
          this.toastr.success('Patient record has been deleted successfully', 'CMS');
          // Instantly erase row from table
          this.patientService.patients = this.patientService.patients.filter(p => p.PatientId !== patient.PatientId);
        },
        error => {
          console.error(error);
          this.toastr.error('Failed to delete patient record.', 'CMS');
        }
      );
    }
  }
}
