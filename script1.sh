#Εργαστήριο ΛΣ 1 / άσκηση 2 / 2022 
#Ονοματεπώνυμο: Δημήτριος  Θεοδωρόπουλος

#
# Ερώτηση 1
#Να γραφτεί script με το όνομα searching το οποίο (α) να δέχεται ως ορίσματα #δύο ακεραίους αριθμούς και (β) να ζητάει από το χρήστη το όνομα ενός #καταλόγου, και με βάση αυτά να εμφανίζει στην οθόνη τα ακόλουθα (τα 1-3 με #χρήση της εντολής find και τα 4-5 με συνδυασμό των εντολών ls και grep): 1. Τα #αρχεία του δέντρου του δοθέντος καταλόγου με εξουσιοδοτήσεις (permissions) #τον πρώτο αριθμό (όρισμα) θεωρώντας τον ως οκταδικό ισοδύναμο. 2. Τα #αρχεία του δέντρου του δοθέντος καταλόγου που άλλαξαν (modify) περιεχόμενα #κατά τις ‘x’ τελευταίες μέρες, όπου ‘x’ ο δεύτερος αριθμός (όρισμα). 3. Τους #υποκαταλόγους του δέντρου του δοθέντος καταλόγου που προσπελάστηκαν #(access) κατά τις ‘x’ τελευταίες μέρες, όπου ‘x’ ο δεύτερος αριθμός (όρισμα). 4. #Τα αρχεία του δοθέντος καταλόγου στα οποία έχουν δικαίωμα ανάγνωσης όλοι #οι χρήστες. 5. Τους υποκαταλόγους του δοθέντος καταλόγου στους οποίους #έχουν δικαίωμα αλλαγών (create/rename/delete files) εκτός από τον ιδιοκτήτη #και άλλοι χρήστες του συστήματος. Πριν από τον εκτύπωση κάθε λίστας από τις #παραπάνω (1 έως 5) να τυπώνεται κατάλληλη επικεφαλίδα η οποία να αναφέρει #μεταξύ άλλων και τον αριθμό των αρχείων (ή υποκαταλόγων) που πρόκειται να #τυπωθούν. Το script να εκτελείται επαναληπτικά όσο επιθυμεί ο χρήστης (για #διαφορετικούς καταλόγους) και στο τέλος (πριν την τελική έξοδο) να εμφανίζει #αθροιστικά το συνολικό αριθμό των ευρεθέντων (αρχείων / υποκαταλόγων) κάθε #περίπτωσης (από τις 1 έως 6) για όλους τους καταλόγους στους οποίους έψαξε.
#Απάντηση:
#Αρχικά διαβάζω τον κατάλογο που θα δώσει ο χρήστης. Έπειτα #κοιτάω αν υπάρχει κατάλογος με τα δικαιώματα που δίνω ως πρώτο #όρισμα. Βρίσκω πόσοι υπάρχουν για να τα εμφανίσω και να τα #προσθέσω στον αθροιστή που έφτιαξα και να εμφανίσω τα ίδια τα #αρχεία. Στο επόμενο ερώτημα κάνω την ίδια διαδικασία αλλά σαν #φίλτρο περνάω αυτή την φορά το δεύτερο όρισμα στο flag mtime #δηλαδή ποτέ τροποποιήθηκε την τελευταία φορά. Στο τρίτο ερώτημα #κάνω ακριβώς την ίδια δουλειά με πριν αλλά αντί για mtime #χρησιμοποιώ atime. Η τελεία που έχω βάλει δείχνει ότι θέλω η #αναζήτησή να γίνει στον τρέχοντα κατάλογο. Στο 4ο ερώτημα με την #εντολή ls -l  εμφανίζω τα δικαιώματα που έχει ο χρήστης στα αρχεία #και στους καταλόγους του τρέχοντος καταλόγου και μετά αυτό το #περνάω σε σωλήνωση με το grep, για να βρω σε ποσά έχουνε όλοι #δικαίωμα ανάγνωσης. Στο 5ο ερώτημα κάνω ακριβώς την ίδια #δουλειά με πριν αλλά αυτήν τη φορά κοιτάω σε ποια  αρχεία και #καταλόγους έχουν δικαίωμα εγγραφής ο root και οι others. Όλη αυτή #την διαδικασία την έχω βάλει σε μια επανάληψη while μέχρι να δωθεί #η λεξη exit.




#!/bin/bash
echo "In order to exit type exit"
read -p "Give me a folder: " folder


while [[ "$folder" !=  "exit" ]]
do
          
#1
    sum=$(find $folder -perm $1 | wc -l)
        find $folder -perm $1 | wc -l
        find $folder -perm $1
#2
    sum=$(($sum + $(find $folder -mtime $2 -ls | wc -l) ))
        find $folder -mtime $2 -ls | wc -l 
        find $folder -mtime $2 -ls
#3
        cd $folder
    sum=$(($sum + $(find . -atime $2 -ls | wc -l) ))
        find . -atime $2 -ls | wc -l
        find . -atime $2 -ls
#4
    sum=$(($sum + $(ls -l | grep ".r..r..r.." | wc -l) ))
        ls -l | grep ".r..r..r.." | wc -l
        ls -l | grep ".r..r..r.."
#5
    sum=$(($sum + $(ls -l | grep -r "..w.....w." | wc -l) ))
        ls -l | grep -r "..w.....w." | wc -l
        ls -l | grep -r "..w.....w."
    echo "Total files and folders: $sum "
    printf "\n\n"
        cd ..
        read -p "Give me a folder: " folder
done