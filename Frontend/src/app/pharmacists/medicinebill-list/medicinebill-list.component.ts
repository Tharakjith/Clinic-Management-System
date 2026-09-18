import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { MedicinebillService } from 'src/app/shared/service/medicinebill.service';

@Component({
  selector: 'app-medicinebill-list',
  templateUrl: './medicinebill-list.component.html',
  styleUrls: ['./medicinebill-list.component.scss']
})
export class MedicinebillListComponent implements OnInit {

   //declare variables
   page: number=1;
   pageSize: number=10;
   searchTerm: string='';

  constructor(public medicinebillService : MedicinebillService,
    private router : Router,private toastr: ToastrService) { }

  ngOnInit(): void {this.medicinebillService.getAllMedicineBill();
  }


}
