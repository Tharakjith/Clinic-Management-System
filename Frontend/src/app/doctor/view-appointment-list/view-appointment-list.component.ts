import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { DoctorService } from 'src/app/shared/service/doctor.service';
import { AppoinmentpatientViewmodel } from 'src/app/shared/model/appoinmentpatient-viewmodel';
import { DatePipe } from '@angular/common';


@Component({
  selector: 'app-view-appointment-list',
  templateUrl: './view-appointment-list.component.html',
  styleUrls: ['./view-appointment-list.component.scss']
})

export class ViewAppointmentListComponent implements OnInit {
  appointments: AppoinmentpatientViewmodel[] = [];
  searchTerm: string = '';
  page: number = 1;
  pageSize: number = 6;

  constructor(
    public doctorService: DoctorService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    // Get doctor ID from route parameters
    const doctorId = Number(this.route.snapshot.paramMap.get('doctorId'));

    if (doctorId) {
      // Fetch appointments for the doctor
      this.doctorService.getTodaysAppointments(doctorId).subscribe(
        (response) => {
          this.appointments = response;
          console.log(this.appointments);
        },
        (error) => {
          console.error('Error fetching appointments:', error);
        }
      );
    }
  }

  filteredAppoinment(): AppoinmentpatientViewmodel[] {
    if (!this.searchTerm) {
      return this.appointments;
    }

    const lowerSearch = this.searchTerm.toLowerCase();

    return this.appointments.filter((appointment) =>
      (appointment.PatientName?.toLowerCase().includes(lowerSearch) ||
        `EC${appointment.TokenNumber}`.toLowerCase().includes(lowerSearch))
    );
  }
}
