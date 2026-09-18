import { formatDate } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Appointment } from 'src/app/shared/model/appointment';
import { Availability } from 'src/app/shared/model/availability';
import { Doctorbyspectn } from 'src/app/shared/model/doctorbyspectn';
import { Doctors } from 'src/app/shared/model/doctors';
import { Specialization } from 'src/app/shared/model/specialization';
import { PatientService } from 'src/app/shared/service/patient.service';

@Component({
  selector: 'app-appointments-bookat',
  templateUrl: './appointments-bookat.component.html',
  styleUrls: ['./appointments-bookat.component.scss']
})
export class AppointmentsBookatComponent implements OnInit {

  //declare variables
  errorMessage: string | null = null;
  specializations: Specialization[] = [];
  doctors: Doctors[] = [];
  doctorspec : Doctorbyspectn[] = [];
  availabilities: any[] = [];
  selectedSpecializationId: number = 0;
  selectedDoctorId: number = 0;
  selectedAvailabilityId: number = 0;
  consultationFee: number = 0;
  appointment: Appointment = new Appointment();
  patientId: number = 0;

  constructor(public patientService: PatientService,
    private router: Router,
    private toastr: ToastrService,
    private route: ActivatedRoute) { }

  ngOnInit(): void {
    // Retrieve Patient ID from route
    this.route.params.subscribe((params) => {
      this.patientId = +params['id']; // Convert to number
      if (this.patientId) {
        this.appointment.PatientId = this.patientId; // Populate PatientId in the appointment object
      }
    });

    // Load specializations
    this.loadSpecializations();
  }

  // Load all specializations
  loadSpecializations(): void {
    this.patientService.getAllSpecializations().subscribe(
      (response: Specialization[]) => {
        this.specializations = response; // Bind response to dropdown
      },
      (error) => {
        this.errorMessage = 'Error fetching specializations: ' + error.message;
      }
    );
  }  

  // Handle specialization change
  // onSpecializationChange(): void {
  //   const specializationId = this.appointment.SpecializationId;
  //   if (specializationId) {
  //     this.patientService.getDoctorsBySpecialization(specializationId).subscribe(
  //       response => {
  //         this.doctors = response;
  //         this.availabilities = [];
  //         this.consultationFee = 0;
  //       },
  //       error => (this.errorMessage = 'Error fetching doctors')
  //     );
  //   }
  // }
  onSpecializationChange(): void {
    const specializationId = this.appointment.SpecializationId;
    if (specializationId) {
      this.patientService.getDoctorsBySpecialization(specializationId).subscribe(
        (response: Doctorbyspectn[]) => {
          this.doctorspec = response; // Bind the response to the `doctors` array
          this.availabilities = [];
          this.consultationFee = 0;
        },
        (error) => {
          this.errorMessage = 'Error fetching doctors: ' + error.message;
        }
      );
    }
  }
  

  // Load availability based on selected doctor
  onDoctorChange(): void {
    const selectedDoc = this.doctorspec.find(d => +d.DoctorId === +this.appointment.DoctorId);
    if (selectedDoc && selectedDoc.ConsultationFee) {
      this.consultationFee = selectedDoc.ConsultationFee;
    }

    this.patientService.getDoctorAvailability(this.appointment.DoctorId).subscribe(
      response => {
        this.availabilities = response;
        if (this.availabilities.length > 0) {
          // default select first slot
          this.selectedAvailabilityId = this.availabilities[0].TimeSlotId || this.availabilities[0].availabilityId;
        }
      },
      error => (this.errorMessage = 'Error fetching doctor availability')
    );

    this.patientService.getConsultationFeeByDoctorId(this.appointment.DoctorId).subscribe(
      response => {
        if (response) {
          this.consultationFee = response;
        }
      },
      error => {}
    );
  }

  // Generate token number based on appointment details
  onGenerateToken(): void {
    const { DoctorId, AppointmentDate } = this.appointment;
    const timeSlotId = this.selectedAvailabilityId;

    if (!DoctorId || !AppointmentDate || !timeSlotId) {
      this.errorMessage = 'Please select Doctor, Date, and Availability Slot before generating a token.';
      return;
    }

    this.patientService.generateToken(DoctorId, AppointmentDate, timeSlotId).subscribe(
      response => {
        this.appointment.TokenNumber = response;
        this.errorMessage = null;
        this.toastr.info(`Token #${response} generated successfully!`);
      },
      error => (this.errorMessage = 'Error generating token: ' + (error?.message || error))
    );
  }

  // Submit the appointment form
  onSubmit(form: NgForm): void {
    if (!this.appointment.TokenNumber) {
      this.errorMessage = 'Please generate a token before booking.';
      return;
    }

    this.appointment.AvailabilityId = Number(this.selectedAvailabilityId) || 1;
    this.appointment.ConsultationFee = Number(this.consultationFee) || 0;

    this.patientService.bookAppointment(this.appointment).subscribe(
      () => {
        this.toastr.success('Appointment booked successfully!');
        form.reset();
        this.router.navigate(['/patients/listappointment']);
      },
      error => (this.errorMessage = 'Error booking appointment: ' + (error?.message || error))
    );
  }
}