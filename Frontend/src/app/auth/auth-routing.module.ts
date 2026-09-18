import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { AdmindashComponent } from './admindash/admindash.component';
import { DoctordashComponent } from './doctordash/doctordash.component';
import { ReceptionistdashComponent } from './receptionistdash/receptionistdash.component';
import { LabtechniciandashComponent } from './labtechniciandash/labtechniciandash.component';
import { PharmacistdashComponent } from './pharmacistdash/pharmacistdash.component';

const routes: Routes = [
  { path: 'login',component: LoginComponent},
  {path:'doctor',component:DoctordashComponent},
  {path: 'receptionist', component: ReceptionistdashComponent},
  {path: 'admin', component: AdmindashComponent},
  {path: 'labtechnician', component: LabtechniciandashComponent},
  {path: 'pharmacists', component: PharmacistdashComponent},
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AuthRoutingModule { }
