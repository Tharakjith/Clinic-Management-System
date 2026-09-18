import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { DoctorService } from 'src/app/shared/service/doctor.service';

@Component({
  selector: 'app-doctordash',
  templateUrl: './doctordash.component.html',
  styleUrls: ['./doctordash.component.scss']
})
export class DoctordashComponent implements OnInit {

  doctorId: number = 0;

  constructor(private route: ActivatedRoute, public doctorService: DoctorService) { }

  ngOnInit(): void {
    this.route.params.subscribe((params) => {
      this.doctorId = +params['doctorId'];
      this.fetchTodaysAppointments();
    });
  }

  fetchTodaysAppointments() {
    this.doctorService.getTodaysAppointments(this.doctorId);
  }

}
