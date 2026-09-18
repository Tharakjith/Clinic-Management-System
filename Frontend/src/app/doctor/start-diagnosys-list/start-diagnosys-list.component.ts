import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Route, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { StartDiagnosy } from 'src/app/shared/model/start-diagnosy';
import { DoctorService } from 'src/app/shared/service/doctor.service';

@Component({
  selector: 'app-start-diagnosys-list',
  templateUrl: './start-diagnosys-list.component.html',
  styleUrls: ['./start-diagnosys-list.component.scss']
})
export class StartDiagnosysListComponent implements OnInit {
  page: number = 1;
  pageSize: number = 6;
  searchTerm: string = "";

  constructor(public doctorService: DoctorService,
    private router:Router, private toastr: ToastrService
  ) { }
  //Lifecycle Hook
  ngOnInit(): void {
    console.log("Hai I am Employee List Compnent !....");
    this.doctorService.getAllDiagnosys();
  }
  //search method
  //1. Filter Based on searchterm, employee service.employees should populate
  filteredDiagnosys() {
    if (!this.searchTerm) {
      return this.doctorService.startDiagnosys;
    }
    //2. Return filteredEmployeesList
    const searchTermLower = this.searchTerm.toLowerCase();

    return this.doctorService.startDiagnosys.filter(e => {
      const empCode = `EC${e.HistoryId}`.toLocaleLowerCase();
      return (
        e.Diagnosis?.toLowerCase().includes(searchTermLower) ||
        empCode.includes(searchTermLower)
      );


      //e.EmployeeId?.includes(searchTermLower)

    });
  }

  editDiagnosys(startDiagnosys: StartDiagnosy): void {
    this.populateDiagnosysData(startDiagnosys);
    this.router.navigate(['/doctor/startdiagnosys/edit/' + startDiagnosys.HistoryId]);
  }

  //Getting Diagnosis Data
  populateDiagnosysData(startDiagnosys: StartDiagnosy) {
    var datePipe = new DatePipe("en-UK");
    let formattedDate: any = datePipe.transform(startDiagnosys.DiagnosysDate, 'yyyy-MM-dd');
    startDiagnosys.DiagnosysDate = formattedDate;
    this.doctorService.formDiagnosysData = { ...startDiagnosys };
  }

  deleteDiagnosys(startDiagnosys: StartDiagnosy) {
    if (confirm(`Are you sure you want to delete diagnosis record #${startDiagnosys.HistoryId}?`)) {
      this.doctorService.deleteDiagnosys(startDiagnosys.HistoryId).subscribe(
        response => {
          this.toastr.success('Diagnosis record has been deleted successfully', 'CMS');
          // Instantly erase row from view
          this.doctorService.startDiagnosys = this.doctorService.startDiagnosys.filter(
            d => d.HistoryId !== startDiagnosys.HistoryId
          );
        },
        error => {
          console.error(error);
          this.toastr.error('Failed to delete diagnosis record.', 'CMS');
        }
      );
    }
  }
}
