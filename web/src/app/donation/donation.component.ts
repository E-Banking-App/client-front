import { Component } from '@angular/core';

@Component({
  selector: 'app-donation',
  templateUrl: './donation.component.html',
  styleUrls: ['./donation.component.scss']
})
export class DonationComponent {
  montant: number| undefined;
  nom: string| undefined;
  donationStatus: string| undefined;

  processDonation() {
    // Logique de traitement de la donation ici
    // Vous pouvez effectuer une requête HTTP vers votre serveur pour traiter la donation
    // Pour cet exemple, nous allons simplement simuler une donation réussie après 2 secondes
    this.donationStatus = 'Traitement de la donation...';

    setTimeout(() => {
      this.donationStatus = 'Donation réussie !';
    }, 2000);
  }


}
