import { Component } from '@angular/core';

@Component({
  selector: 'app-payementpage',
  templateUrl: './payementpage.component.html',
  styleUrls: ['./payementpage.component.scss']
})
export class PayementpageComponent {
  cardNumber: string | undefined;
  expiryDate: string | undefined;
  cvv: string | undefined;
  paymentStatus: string | undefined;

  processPayment() {
    // Perform payment processing logic here
    // You can make an HTTP request to your server to process the payment
    // For this example, we'll simulate a successful payment after 2 seconds
    this.paymentStatus = 'Processing payment...';

    setTimeout(() => {
      this.paymentStatus = 'Payment successful!';
    }, 2000);
  }

}
