import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DoctorComponent } from './doctor/doctor.component';
import { AuthComponent } from './auth/auth.component';
import { AdminComponent } from './admin/admin.component';
import { MedicineManagementsComponent } from './medicine-managements/medicine-managements.component';
import { ReceptionistsComponent } from './receptionists/receptionists.component';
import { PharmacistsComponent } from './pharmacists/pharmacists.component';
import { LabComponent } from './lab/lab.component';
import { DoctormgmtComponent } from './doctormgmt/doctormgmt.component';
import { AuthGuard } from './shared/guard/auth.guard';

const routes: Routes = [

  { path: '', redirectTo: '/auth/login', pathMatch: 'full' },

  // Role-Protected Feature Modules
  {
    path: 'doctor', component: DoctorComponent,
    canActivate: [AuthGuard],
    data: { roles: [1, 2] },
    loadChildren: () => import('./doctor/doctor.module')
      .then(e => e.DoctorModule)
  },
  {
    path: 'uregistration',
    canActivate: [AuthGuard],
    data: { roles: [1] },
    loadChildren: () => import('./uregistration/uregistration.module')
      .then(e => e.UregistrationModule)
  },
  {
    path: 'doctormgmt', component: DoctormgmtComponent,
    canActivate: [AuthGuard],
    data: { roles: [1] },
    loadChildren: () => import('./doctormgmt/doctormgmt.module')
      .then(x => x.DoctormgmtModule),
  },
  {
    path: 'patients', component: ReceptionistsComponent,
    canActivate: [AuthGuard],
    data: { roles: [1, 3] },
    loadChildren: () => import('./receptionists/receptionists.module')
      .then(x => x.ReceptionistsModule),
  },
  {
    path: 'lab', component: LabComponent,
    canActivate: [AuthGuard],
    data: { roles: [1, 5] },
    loadChildren: () => import('./lab/lab.module')
      .then(x => x.LabModule),
  },
  {
    path: 'admin', component: AdminComponent,
    canActivate: [AuthGuard],
    data: { roles: [1] },
    loadChildren: () => import('./admin/admin.module').then(e => e.AdminModule)
  },
  {
    path: 'medicine-managements', component: MedicineManagementsComponent,
    canActivate: [AuthGuard],
    data: { roles: [1, 4] },
    loadChildren: () => import('./medicine-managements/medicine-managements.module')
      .then(e => e.MedicineManagementsModule)
  },
  {
    path: 'medicine-prescriptions', component: PharmacistsComponent,
    canActivate: [AuthGuard],
    data: { roles: [1, 4] },
    loadChildren: () => import('./pharmacists/pharmacists.module')
      .then(e => e.PharmacistsModule)
  },

  // Authentication & Role Dashboards
  {
    path: 'auth', component: AuthComponent,
    loadChildren: () => import('./auth/auth.module')
      .then(x => x.AuthModule)
  },

  // Route Aliases
  { path: 'register', redirectTo: 'uregistration', pathMatch: 'prefix' },
  { path: 'doctormanagement', redirectTo: 'doctormgmt', pathMatch: 'prefix' },

  { path: '**', redirectTo: 'auth/login' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
