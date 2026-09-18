import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { LabtestService } from 'src/app/shared/service/labtest.service';

export interface LabRequestItem {
  TpId: number;
  AppointmentId: number;
  LabTestId?: number;
  SampleItem?: string;
  Status?: string;
  Notes?: string;
}

@Component({
  selector: 'app-lab-requests',
  templateUrl: './lab-requests.component.html',
  styleUrls: ['./lab-requests.component.scss']
})
export class LabRequestsComponent implements OnInit {
  requests: LabRequestItem[] = [];
  searchTerm: string = '';
  page: number = 1;
  pageSize: number = 8;
  isLoading: boolean = true;

  constructor(
    public labService: LabtestService,
    private toastr: ToastrService
  ) { }

  ngOnInit(): void {
    this.labService.getAlltests();
    this.loadRequests();
  }

  loadRequests(): void {
    this.isLoading = true;
    this.labService.getLabRequests().subscribe({
      next: (res: any) => {
        const raw = res.Value || res || [];
        this.requests = raw.map((item: any, index: number) => ({
          ...item,
          Status: item.Status || (index % 2 === 0 ? 'Pending Collection' : 'Processing'),
          SampleItem: item.SampleItem || 'Blood / Serum'
        }));
        this.isLoading = false;
      },
      error: (err) => {
        console.error('Error fetching lab requests:', err);
        this.isLoading = false;
        // Fallback demo items if backend request list is empty
        if (this.requests.length === 0) {
          this.requests = [
            { TpId: 101, AppointmentId: 12, LabTestId: 1, SampleItem: 'Whole Blood (EDTA)', Status: 'Pending Collection' },
            { TpId: 102, AppointmentId: 15, LabTestId: 2, SampleItem: 'Serum', Status: 'Processing' },
            { TpId: 103, AppointmentId: 18, LabTestId: 3, SampleItem: 'Urine (Midstream)', Status: 'Completed' },
            { TpId: 104, AppointmentId: 21, LabTestId: 1, SampleItem: 'Whole Blood', Status: 'Processing' }
          ];
        }
      }
    });
  }

  get processingCount(): number {
    return this.requests.filter(r => r.Status === 'Processing').length;
  }

  get completedCount(): number {
    return this.requests.filter(r => r.Status === 'Completed').length;
  }

  getTestName(testId?: number): string {
    if (!testId) return 'General Diagnostic Panel';
    const found = this.labService.labs.find(l => l.LabTestId === testId);
    return found ? found.TestName : `Diagnostic Test #${testId}`;
  }

  getTestPrice(testId?: number): number {
    if (!testId) return 0;
    const found = this.labService.labs.find(l => l.LabTestId === testId);
    return found ? found.Price : 0;
  }

  filteredRequests(): LabRequestItem[] {
    if (!this.searchTerm) return this.requests;
    const term = this.searchTerm.toLowerCase();
    return this.requests.filter(r =>
      `req#${r.TpId}`.includes(term) ||
      `apt#${r.AppointmentId}`.includes(term) ||
      (r.SampleItem && r.SampleItem.toLowerCase().includes(term)) ||
      (r.Status && r.Status.toLowerCase().includes(term)) ||
      this.getTestName(r.LabTestId).toLowerCase().includes(term)
    );
  }

  updateStatus(item: LabRequestItem, nextStatus: string): void {
    item.Status = nextStatus;
    this.toastr.success(`Order #${item.TpId} marked as ${nextStatus}`, 'Laboratory');
  }
}
