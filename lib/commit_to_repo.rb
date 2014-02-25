@w = Wikialgo.find_by("title"=>/krusk/i)
e = Element.new
e.type = "code"
e.value = '<pre>
//
//  Krushal.cpp
//
//  Created by Chintan Ghate on 24/02/2014.
//  Copyright (c) 2014 Chintan Ghate. All rights reserved.
//

#include <iostream>
#include <vector>
#include <queue>
#include <set>

using namespace std;

//route_weight stores weight of edge between u & v <weight, <u, v> >
typedef pair<int,pair<int,int> > route_weight; 
typedef priority_queue<route_weight, vector<route_weight>, greater<route_weight> > min_priority_queue;

void print_route(route_weight A);
vector<route_weight> MST_KRUSHAL(int N, min_priority_queue Q);
int root(int a, int id[]);
void Union(int a, int b, int id[],int size[]);
bool isConnected(int a, int b,int id[]);

int main()
{
    int N, E; //Graph with N vertices [0,N-1] and E edges 
    cin >>N >>E;

    int u, v, w;
    //Q is a minimum priority queue to store an edge (u->v) and its weight (w) as <w, <u,v> >
    min_priority_queue Q;  
    for (int i = 0; i < E; ++i)
    {
        cin >>u >>v >>w;
        Q.push(make_pair(w, make_pair(u, v)));
    }

    vector<route_weight> mst_routes(MST_KRUSHAL(N, Q));
    for (int i = 0; i < mst_routes.size(); ++i)
    {
        print_route(mst_routes[i]);
    }
    return 0;
}

vector<route_weight> MST_KRUSHAL(int N, min_priority_queue Q)
{
    vector<route_weight> mst_routes;

    //Creating the disjoint set forest for each vertex. This stores information whether two nodes are connected by a path or not.
    int connected[N], size[N];
    for (int i = 0; i < N; ++i)
    {
        connected[i]=i;
        size[i] = 1;
    }

    while(!Q.empty())
    {
        int u = Q.top().second.first, v = Q.top().second.second, w = Q.top().first;
         
        if(!isConnected(u, v, connected)) //if u and v are not connected by a path.
        {
            mst_routes.push_back(make_pair(w, make_pair(u, v)));
            Union(u, v, connected,size); // UNION(u,v)
        }
        Q.pop();
    }
    return mst_routes;
}

int root(int a, int id[])
{
    while(a != id[a])
    {
        id[a] = id[id[a]];
        a = id[a];
    }
    return a;
}

void Union(int a,int b, int id[],int size[])
{
    int roota = root(a,id);
    int rootb = root(b,id);
    if(size[roota] < size[rootb])
    {
        id[roota] = rootb;
        size[rootb] += size[roota];
    }
    else
    {
        id[rootb] = roota;
        size[roota] += size[rootb];
    }
    return ;
}

bool isConnected(int a,int b, int id[])
{
    return (root(a,id) == root(b,id));
}

void print_route(route_weight A)
{
    cout <<A.second.first <<" -> " <<A.second.second <<" : " <<A.first <<"\n";
    return;
}
</pre>'
e.user = "Chintan Ghate" 
e.wikialgo = @w
e.save