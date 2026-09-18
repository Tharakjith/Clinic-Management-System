import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { MedicinedistributeService } from 'src/app/shared/service/medicinedistribute.service';
import { MedicinepresciptionService } from 'src/app/shared/service/medicinepresciption.service';

@Component({
  selector: 'app-medicinedistribute-add',
  templateUrl: './medicinedistribute-add.component.html',
  styleUrls: ['./medicinedistribute-add.component.scss']
})
export class MedicinedistributeAddComponent implements OnInit {

  //declare variables
  errorMessage: string | null = null;
  distributionDate = new Date().toISOString().slice(0, 10); // Set to today's date
  prescriptionId: number | null = null;

  constructor(
    public medicinedistributeService:MedicinedistributeService,
    private route: ActivatedRoute,
    private router:Router,private toastr: ToastrService) { }

  ngOnInit(): void {
    this.route.params.subscribe(params => {
      this.prescriptionId = +params['id'] || +params['pid'];
      if (this.prescriptionId) {
        this.getPrescriptionDetails(this.prescriptionId);
      }
    });
  }

  getPrescriptionDetails(prescriptionId: number): void {
    this.medicinedistributeService.getPrescriptionDetails(prescriptionId).subscribe(
      (response) => {
        this.medicinedistributeService.formMedicinedistributeData = response;
      },
      (error) => {
        this.toastr.error('Failed to fetch prescription details', 'Error');
        console.error(error);
      }
    );
  }

  onSubmit(mdaForm: NgForm): void {
    if (mdaForm.invalid) {
      return;
    }
    this.addMedicineDistribute(mdaForm);
  }

  //Insert Method
  addMedicineDistribute(mdaForm: NgForm): void {
    console.log("inserting...");
    this.medicinedistributeService.insertMedicineDistribute(mdaForm.value).subscribe(
      (response)=>{
        console.log(response);
        this.toastr.success('Medicine dispensed and recorded successfully', 'CMS Dispensary');
        this.errorMessage = null;
        this.medicinedistributeService.getAllMedicineDistribute();
        this.router.navigate(['/medicine-prescriptions/Medicineprescriptionlist']);
        mdaForm.reset();
      },
      (error)=>{
        console.log(error);
        this.toastr.error('An error occurred while dispensing medicine', 'CMS Dispensary');
        this.errorMessage ='An error occurred: ' + (error?.message || error);
      }
    );
  }
}
