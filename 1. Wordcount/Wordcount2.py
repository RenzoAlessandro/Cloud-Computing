import numpy as np
import matplotlib.pyplot as plt

nombre_fichero = "Salida.txt"

class Wordcount:
    def __init__(self):
        self.vocab = [] #lista de palabras
        self.size_vocab = 0

    def BagOfWords(self , sentences):
        for sentence in sentences:
            for word in sentence.split(' '):
                if word not in self.vocab:
                    self.vocab.append(word)
        self.vocab.sort()
        print('BAG OF WORDS (BoW): \n', self.vocab)
        self.size_vocab = len(self.vocab)
        print('TAMAÑO DEL VOCABULARIO: \n', self.size_vocab,'palabras')

    def frequency_matrix(self , sentence): # 'i like it'
        words = sentence.split(' ')
        vector = np.zeros(len(self.vocab))
        for word in words:
            for i, _word in enumerate(self.vocab):
                if _word == word:
                    vector[i] += 1
        return vector

f = open ('texto1.txt')
inputs = f.read().split('\n')
f.close()

bow = Wordcount()
bow.BagOfWords(inputs)

vector_temp = np.zeros(bow.size_vocab)
for sentence in inputs:
    vector = bow.frequency_matrix(sentence)
    for j in range(bow.size_vocab):
        vector_temp[j] = vector_temp[j] + vector[j]
    print('MATRIZ DE INCIDENCIA: \n', sentence ,vector)

print('MATRIZ DE FRECUENCIA: \n', vector_temp)

plt.title('Histograma del Problema Wordcount')
plt.ylabel('Frecuencia')
plt.xlabel('Palabras')
fichero = open(nombre_fichero, "w")
for j in range(bow.size_vocab):
    fichero.write('{}'.format(vector_temp[j]) + ' - ' + '{}'.format(bow.vocab[j]) + '\n')
    plt.bar(bow.vocab[j], height=vector_temp[j])
fichero.close()
plt.xticks(rotation=90)
plt.show()

