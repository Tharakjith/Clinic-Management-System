import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PatientsListComponent } from './patients-list/patients-list.component';
import { PatientsEditComponent } from './patients-edit/patients-edit.component';
import { PatientsAddComponent } from './patients-add/patients-add.component';
import { AppointmentsBookatComponent } from './appointments-bookat/appointments-bookat.component';

const routes: Routes = [
  //SETTING-UP CHILDREN ROUTES
  //employee-list
  {path : 'list', component: PatientsListComponent},

  //employee-add
  {path : 'add', component: PatientsAddComponent},

  //employee-edit
  {path : 'edit/:id', component: PatientsEditComponent},

  {path : 'book/:id', component: AppointmentsBookatComponent},

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReceptionistsRoutingModule { }
