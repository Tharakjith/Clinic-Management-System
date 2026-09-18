import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ReceptionistsRoutingModule } from './receptionists-routing.module';
import { ReceptionistsComponent } from './receptionists.component';
import { PatientsAddComponent } from './patients-add/patients-add.component';
import { PatientsEditComponent } from './patients-edit/patients-edit.component';
import { PatientsListComponent } from './patients-list/patients-list.component';
import { NgxPaginationModule } from 'ngx-pagination';
import { FormsModule } from '@angular/forms';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { AppointmentsBookatComponent } from './appointments-bookat/appointments-bookat.component';


@NgModule({
  declarations: [
    ReceptionistsComponent,
    PatientsAddComponent,
    PatientsEditComponent,
    PatientsListComponent,
    AppointmentsBookatComponent
  ],
  imports: [
    CommonModule,
    ReceptionistsRoutingModule,
    NgxPaginationModule,
    Ng2SearchPipeModule,
    FormsModule
  ]
})
export class ReceptionistsModule { }
