import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LabListComponent } from './lab-list/lab-list.component';
import { LabAddComponent } from './lab-add/lab-add.component';
import { LabEditComponent } from './lab-edit/lab-edit.component';
import { LabRequestsComponent } from './lab-requests/lab-requests.component';

const routes: Routes = [
  { path: 'list', component: LabListComponent },
  { path: 'requests', component: LabRequestsComponent },
  { path: 'add', component: LabAddComponent },
  { path: 'edit/:id', component: LabEditComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LabRoutingModule { }
