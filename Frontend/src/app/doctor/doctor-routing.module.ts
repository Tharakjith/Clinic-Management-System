import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ViewAppointmentListComponent } from './view-appointment-list/view-appointment-list.component';
import { StartDiagnosysAddComponent } from './start-diagnosys-add/start-diagnosys-add.component';
import { StartDiagnosysEditComponent } from './start-diagnosys-edit/start-diagnosys-edit.component';
import { StartDiagnosysListComponent } from './start-diagnosys-list/start-diagnosys-list.component';


const routes: Routes = [
  //employee List
  { path: 'list/:doctorId', component: ViewAppointmentListComponent},

  //employee Add
  {path:'startdiagnosys/add', component: StartDiagnosysAddComponent},

  //employee Edit
  {path:'startdiagnosys/edit/:id',component:StartDiagnosysEditComponent},
  {path:'startdiagnosys/list',component:StartDiagnosysListComponent},


];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DoctorRoutingModule { }
