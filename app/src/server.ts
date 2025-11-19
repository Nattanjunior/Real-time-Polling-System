import { fastify } from "fastify";

const app = fastify({
  logger: true,
});

app.get("/", async (request, reply) => {
  reply.send({ hello: "world" });
});

app.listen({ port: 3000 }, (err, address) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
  console.log(`Server listening at ${address}`);
});
