import sys
import numpy as np
import matplotlib.pyplot as plt

nombre_fichero = "Salida.txt"

class Wordcount:
    def __init__(self):
        self.vocab = [] #lista de palabras
        self.size_vocab = 0

    def BagOfWords(self , sentences):
        #Construccion del vocabulario
        for sentence in sentences:
            for word in sentence.split():
                if word not in self.vocab:
                    self.vocab.append(word)
        self.vocab.sort() #ordenado alfabeticamente
        print('BAG OF WORDS (BoW): \n', self.vocab) #imprimimos el vocabulario
        self.size_vocab = len(self.vocab)
        print('EL NUMERO DE PALABRAS: \n', self.size_vocab, ' palabras') #Cuantas palabras tenemos
          
    def frequency_matrix(self , words):
        vector = np.zeros(self.size_vocab)
        for word in words:
            for i, _word in enumerate(self.vocab):
                if _word == word:
                    vector[i] += 1
        print('MATRIZ DE FRECUENCIA: \n', vector)
        return vector
    
    def save_result(self):
        fichero = open(nombre_fichero, "w")
        for j in range(self.size_vocab):
            fichero.write('{}'.format(vector[j]) + ' - ' + '{}'.format(self.vocab[j]) + '\n')
        fichero.close()

    def histogram_result(self, words):
        plt.title('Histograma del Problema Wordcount')
        plt.ylabel('Frecuencia')
        plt.xlabel('Palabras')
        plt.hist(words, bins=range(self.size_vocab+1), alpha=1, edgecolor = 'black',  linewidth=1)
        plt.xticks(rotation=90)
        #plt.gcf().autofmt_xdate()
        plt.show()


if __name__ == "__main__":
    f = open ('sample1.txt')
    inputs = [word for line in f for word in line.split()]
    f.close()

    bow = Wordcount()
    bow.BagOfWords(inputs)

    vector = bow.frequency_matrix(inputs)

    bow.save_result()
    bow.histogram_result(inputs)
