import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
//import { LabtestlistListComponent } from './labtestlist-list/labtestlist-list.component';

const routes: Routes = [

  //{path : 'Labtestlist', component: LabtestlistListComponent},
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LabtechniciansRoutingModule { }
