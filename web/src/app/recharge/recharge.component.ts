import { Component } from '@angular/core';

@Component({
  selector: 'app-recharge',
  templateUrl: './recharge.component.html',
  styleUrls: ['./recharge.component.scss']
})
export class RechargeComponent {
  choix: string| undefined;
  numeroTelephone: string | undefined;
  montant: number| undefined;
  rechargeStatus: string| undefined;


  processRecharge() {
    // Logique de traitement de la recharge ici
    // Vous pouvez effectuer une requête HTTP vers votre serveur pour traiter la recharge
    // Pour cet exemple, nous allons simplement simuler une recharge réussie après 2 secondes
    this.rechargeStatus = 'Traitement de la recharge...';

    setTimeout(() => {
      this.rechargeStatus = 'Recharge réussie !';
    }, 2000);
  }

}
