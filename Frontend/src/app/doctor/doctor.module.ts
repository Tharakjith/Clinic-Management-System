import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DoctorRoutingModule } from './doctor-routing.module';
import { DoctorComponent } from './doctor.component';
import { StartDiagnosysAddComponent } from './start-diagnosys-add/start-diagnosys-add.component';
import { StartDiagnosysEditComponent } from './start-diagnosys-edit/start-diagnosys-edit.component';
import { StartDiagnosysListComponent } from './start-diagnosys-list/start-diagnosys-list.component';
import { AddMedicineAddComponent } from './add-medicine-add/add-medicine-add.component';
import { AddMedicineListComponent } from './add-medicine-list/add-medicine-list.component';
import { AddMedicineEditComponent } from './add-medicine-edit/add-medicine-edit.component';
import { LabtestaddAddComponent } from './labtestadd-add/labtestadd-add.component';
import { LabtestaddEditComponent } from './labtestadd-edit/labtestadd-edit.component';
import { LabtestaddListComponent } from './labtestadd-list/labtestadd-list.component';
import { NgxPaginationModule } from 'ngx-pagination';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { ViewAppointmentListComponent } from './view-appointment-list/view-appointment-list.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    DoctorComponent,
    ViewAppointmentListComponent,
    StartDiagnosysAddComponent,
    StartDiagnosysEditComponent,
    StartDiagnosysListComponent,
    AddMedicineAddComponent,
    AddMedicineListComponent,
    AddMedicineEditComponent,
    LabtestaddAddComponent,
    LabtestaddEditComponent,
    LabtestaddListComponent
  ],
  imports: [
    CommonModule,
    DoctorRoutingModule,
    NgxPaginationModule,
    Ng2SearchPipeModule,
    FormsModule,
    ReactiveFormsModule
  ]
})
export class DoctorModule { }
