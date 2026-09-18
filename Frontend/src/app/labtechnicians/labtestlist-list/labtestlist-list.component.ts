// import { Component, OnInit } from '@angular/core';
// import { ToastrService } from 'ngx-toastr';
// import { Labtestapp } from 'src/app/shared/model/labtestapp';
// import { LabtestpresService } from 'src/app/shared/service/labtestpres.service';

// @Component({
//   selector: 'app-labtestlist-list',
//   templateUrl: './labtestlist-list.component.html',
//   styleUrls: ['./labtestlist-list.component.scss']
// })
// export class LabtestlistListComponent implements OnInit {

//   labTests: Labtestapp[] = [];
//   page: number = 1;
//   pageSize: number = 10;

//   searchTerm: string = '';

//   constructor(
//     private labtestService: LabtestpresService,
//     private toastr: ToastrService
//   ) { }

//   ngOnInit(): void {
//     this.loadLabTestsForToday();
//   }

//   onPageChange(page: number): void {
//     this.page = page;
//   }

//   loadLabTestsForToday(): void {
//     this.labtestService.getLabTestsForToday().subscribe(
//       (response: any) => {
//         if (response.success) {
//           this.labTests = response.data;
//         } else {
//           this.toastr.error(response.message);
//         }
//       },
//       (error) => {
//         this.toastr.error('Error loading lab tests.');
//       }
//     );
//   }

//   // Search Method
//   filteredLabTests() {
//     if (!this.searchTerm) {
//       return this.labTests;
//     }

//     const searchTermLower = this.searchTerm.toLowerCase();
//     return this.labTests.filter((e) =>
//       e.PatientName.toLowerCase().includes(searchTermLower)
//     );
//   }

//   // Generate Lab Report Method
//   generateLabReport(labTestId: number): void {
//     // Add your logic to generate a lab report for the given labTestId
//     console.log('Generating Lab Report for LTReportId:', labTestId);
//     this.toastr.success('Lab report generated!');
//   }
// }

