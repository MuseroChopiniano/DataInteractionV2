using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class ClusterHelper
    {

        public static int[] Cluster(double[][] data, int numClusters)
        {
            double[][] normalizedData = Normalized(data);
            bool changed = true; 
            bool success = true;
            int[] clustering = InitClustering(normalizedData.Length, numClusters, 0);
            double[][] means = Allocate(numClusters, normalizedData[0].Length);
            int maxCount = normalizedData.Length * 10;
            int counter = 0;
            while (changed == true && success == true && counter < maxCount)
            {
                ++counter;
                success = UpdateMeans(normalizedData, clustering, means);
                changed = UpdateClustering(normalizedData, clustering, means);
            }
            return clustering;
        }

        private static double[][] Normalized(double[][] data)
        {
            double[][] result = new double[data.Length][];
            for (int i = 0; i < data.Length; ++i)
            {
                result[i] = new double[data[i].Length];
                Array.Copy(data[i], result[i], data[i].Length);
            }

            for (int j = 0; j < result[0].Length; ++j)
            {
                double colSum = 0.0;
                for (int i = 0; i < result.Length; ++i)
                {
                    colSum += result[i][j];
                }
                double mean = colSum / result.Length;
                double sum = 0.0;
                for (int i = 0; i < result.Length; ++i)
                {
                    sum += (result[i][j] - mean) * (result[i][j] - mean);
                }
                double sd = sum / result.Length;
                for (int i = 0; i < result.Length; ++i)
                {
                    result[i][j] = (result[i][j] - mean) / sd;
                }
                   
            }
            return result;
        }

        private static int[] InitClustering(int numTuples, int numClusters, int seed)
        {
            Random random = new Random(seed);
            int[] clustering = new int[numTuples];
            for (int i = 0; i < numClusters; ++i)
            {
                clustering[i] = i;
            }
              
            for (int i = numClusters; i < clustering.Length; ++i)
            {
                clustering[i] = random.Next(0, numClusters);
            }
               
            return clustering;
        }

        private static bool UpdateMeans(double[][] data, int[] clustering, double[][] means)
        {
            int numClusters = means.Length;
            int[] clusterCounts = new int[numClusters];
            for (int i = 0; i < data.Length; ++i)
            {
                int cluster = clustering[i];
                ++clusterCounts[cluster];
            }

            for (int k = 0; k < numClusters; ++k)
            {
                if (clusterCounts[k] == 0)
                {
                    return false;
                }
            }
            for (int k = 0; k < means.Length; ++k)
                for (int j = 0; j < means[k].Length; ++j) {
                    means[k][j] = 0.0;
                }
                  

            for (int i = 0; i < data.Length; ++i)
            {
                int cluster = clustering[i];
                for (int j = 0; j < data[i].Length; ++j)
                {
                    means[cluster][j] += data[i][j];
                }
                    
            }

            for (int k = 0; k < means.Length; ++k)
                for (int j = 0; j < means[k].Length; ++j)
                {
                    means[k][j] /= clusterCounts[k];
                }
            return true;
        }
        private static double[][] Allocate(int numClusters, int numColumns)
        {
            double[][] result = new double[numClusters][];
            for (int k = 0; k < numClusters; ++k)
                result[k] = new double[numColumns];
            return result;
        }

        private static bool UpdateClustering(double[][] data, int[] clustering, double[][] means)
        {
            int numClusters = means.Length;
            bool changed = false;

            int[] newClustering = new int[clustering.Length];
            Array.Copy(clustering, newClustering, clustering.Length);

            double[] distances = new double[numClusters];

            for (int i = 0; i < data.Length; ++i)
            {
                for (int k = 0; k < numClusters; ++k)
                    distances[k] = Distance(data[i], means[k]);

                int newClusterID = MinIndex(distances);
                if (newClusterID != newClustering[i])
                {
                    changed = true;
                    newClustering[i] = newClusterID;
                }
            }

            if (changed == false)
                return false;

            int[] clusterCounts = new int[numClusters];
            for (int i = 0; i < data.Length; ++i)
            {
                int cluster = newClustering[i];
                ++clusterCounts[cluster];
            }

            for (int k = 0; k < numClusters; ++k)
                if (clusterCounts[k] == 0)
                    return false;

            Array.Copy(newClustering, clustering, newClustering.Length);
            return true;
        }
        private static double Distance(double[] tuple, double[] mean)
        {
            double sumSquaredDiffs = 0.0;
            for (int j = 0; j < tuple.Length; ++j)
                sumSquaredDiffs += Math.Pow((tuple[j] - mean[j]), 2);
            return Math.Sqrt(sumSquaredDiffs);
        }
        private static int MinIndex(double[] distances)
        {
            int indexOfMin = 0;
            double smallDist = distances[0];
            for (int k = 0; k < distances.Length; ++k)
            {
                if (distances[k] < smallDist)
                {
                    smallDist = distances[k];
                    indexOfMin = k;
                }
            }
            return indexOfMin;
        }
    }
}
